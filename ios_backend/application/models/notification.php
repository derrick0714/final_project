<?php
class Notification extends CI_Model {


    function set($uid, $content, $eventId)
    {
    	$sql = "SELECT `start_time` FROM `event` WHERE eid='$eventId'";
    	//echo $sql;
    	$query = $this->db->query($sql);
    	$fireTime = "1900-1-1 00:00:00";
    	if($query->num_rows()){
    		$fireTime = $query->result()[0]->start_time;
        	$sql = "INSERT INTO `notification` (`uid`, `content`, `fetched`, `timestamp`,`fireTime`) VALUES ('$uid', '$content', '0', NOW(),'$fireTime')";
       	 	return $this->db->query($sql);
        }
        return 0;
    }

    function get($uid)
    {
        $sql = "SELECT * FROM `notification` WHERE `fetched` ='false' and `uid` ='$uid'";
        $result = $this->db->query($sql);
        $sql = "UPDATE  `notification` SET  `fetched` =  '1' WHERE  `uid` ='$uid'";
        $this->db->query($sql);
        return  $result;
    }

}
?>