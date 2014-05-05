<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Ios_api_v1 extends CI_Controller {
	var $api_result = array();
	var $request;

	function __construct() {
		parent::__construct();
		$this->request = json_decode(file_get_contents('php://input'));
	}

	function set($key, $value){
		$this->api_result[$key] = $value;
	} 

	function respond(){
		header('Content-Type: application/json');
		echo json_encode($this->api_result,JSON_PRETTY_PRINT);
	}

	//sign up
	public function signup()
	{	
		$query = $this->User->searchByName($this->request->user);
		if($query->num_rows() >=1 ){
			$this->set('result','false');
			$this->set('desc','This user name has been taken');
		}else{
			$this->User->addUser($this->request->user, $this->request->pwd, $this->request->gender);
			$this->set('result','true');
			$this->set('desc','sign up successfully');
		}
		$this->respond();

	}

	//login check
	public function login()
	{	
		$query = $this->User->search_entry($this->request->user, $this->request->pwd);

		if($query->num_rows() >=1 ){
			$this->set('result','true');
			$this->set('desc','login success');
			$this->set('uid', $query->result()[0]->uid);
		}
		else{
			$this->set('result','false');
			$this->set('desc','login failed');
			$this->set('uid',0);
		}

		$this->respond();	
	}



	public function createEvent(){

		$this->Event->creatorID 	= $this->request->creatorID;
		$this->Event->title 		= $this->request->title;
		$this->Event->subject 		= $this->request->subject;
		$this->Event->startTime 	= $this->request->startTime;
		$this->Event->endTime 		= $this->request->endTime;
		$this->Event->notes 		= $this->request->notes;
		$this->Event->location 		= $this->request->location;
		$this->Event->latitude 		= $this->request->latitude;
		$this->Event->longitude 	= $this->request->longitude;

		$this->Event->insert_entry();
		$this->set('result','true');
		$this->respond();
	}


	public function allEvent(){
		$query = $this->Event->getByCondition($this->request->keyword,$this->request->sortBy, $this->request->subject, $this->request->latitude,$this->request->longitude );
		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newEvent($row));
		}

		$this->respond();
	}

	public function eventByStatus(){

		$query = $this->Event->getByStatus($this->request->uid, $this->request->status);
		//$query = $this->Event->getByStatus(14, 1);
		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newEvent($row));
		}

		$this->respond();
	}

	// public function getNotification(){
	// 	$query = $this->Event->getNotification($this->request->uid);
	// 	foreach ($query->result() as $row){	
	// 		array_push($this->api_result, $this->newEvent($row));
	// 	}
	// 	$this->respond();
	// }

	public function applyEvent(){

		$query = $this->Event->checkTakeEvent($this->request->uid, $this->request->eventId);
		if($query->num_rows() >=1 ){
			$this->set('result','false');
			$this->set('desc','You have already appied this event');
		}else{
			$this->Event->insertTakeEvent($this->request->uid, $this->request->eventId);
			$this->Event->addCandidates($this->request->eventId);
			$this->set('result','true');
			$this->set('desc','Apply success!');
		}
		$this->respond();
	}

	public function getUserInfo(){

		$query = $this->User->getUserInfo($this->request->uid);
		//$query = $this->User->getUserInfo(6);
		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newUser($row));
		}
		$this->respond();
	}

	public function updatePhoto(){

		$query = $this->User->updatePhoto($this->request->uid, $this->request->photo);
		
		$this->set('result','true');
		$this->respond();
	}

	public function candidateList(){

		$query = $this->Event->candidateList($this->request->eventId);

		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newUser($row));
		}
		$this->respond();
	}

	public function applyCandidate(){

		$query = $this->Event->applyCandidate($this->request->eventId, $this->request->candidateId);

		$this->set('result','true');
		$this->respond();
	}

	public function setNotification(){
		$this->Notification->set($this->request->userId, $this->request->content,$this->request->eventId);
		//$this->Notification->set(6, "1",1);
		$this->set('result','true');
		$this->respond();
	}

	public function getNotification(){
		$query = $this->Notification->get(6);
		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newNotification($row));
		}
		$this->respond();
	}

	public function addComment(){
		$query = $this->Comments->insert($this->request->uid, $this->request->commenterId,$this->request->content,$this->request->rating,$this->request->eventId );

		$this->set('result','true');
		$this->respond();
	}
	public function getComments(){
		//$this->request->uid
		$query = $this->Comments->get($this->request->uid);

		foreach ($query->result() as $row){	
			array_push($this->api_result, $this->newComment($row));
		}
		$this->respond();
	}


	function newNotification($row){

		$arr = array();
		$arr['userID'] = $row->uid;
		$arr['content'] =  $row->content;
		$arr['fireTime'] =  $row->fireTime;
		return $arr;
	}

	function newComment($row){
		$arr = array();
		$arr['userID'] = $row->commenter_id;
		$arr['content'] =  $row->content;
		$arr['createTime'] =  $row->timestamp;
		$arr['rating'] = $row->rating;
		return $arr;
	}

	function newUser($row ){
		$arr = array();
		$arr['userID'] = $row->uid;
		$arr['userName'] =  $row->uname;
		$arr['gender'] =  $row->gender;
		$arr['userRating'] =  $row->rating;
		return $arr;
	}


	function newEvent($row ){
		$arr = array();
		$arr['eventID'] = $row->eid;
		$arr['title'] =  $row->ename;
		$arr['subject'] =  $row->subject;
		$arr['startTime'] =  $row->start_time;
		$arr['endTime'] =  $row->end_time;
		$arr['notes'] =  $row->notes;
		$arr['location'] =  $row->location_desc;
		$arr['latitude'] =  $row->location_latitude;
		$arr['longitude'] =  $row->location_longitude;
		$arr['creatorID'] =  $row->uid;
		$arr['createTime'] =  $row->create_time;
		$arr['status'] =  $row->status;
		$arr['canidateID'] =  $row->selected_uid;
		$arr['numOfCandidates'] = $row->numOfCandidates;
		return $arr;
	}






	
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */