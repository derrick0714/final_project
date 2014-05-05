<?php
class Event extends CI_Model {

    var $eventID;
    var $creatorID;
    var $canidateID;
    
    var $title;
    var $subject;
    var $startTime;
    var $endTime;
    var $createTime;
    var $notes;
    var $status;

    var $location;
    var $latitude;
    var $longitude;


    function search_entry($userName, $passWord)
    {
        $sql = "select * from `user` where uname = '$userName' and upassword = '$passWord' order by timestamp desc";
        return $this->db->query($sql);
    }

    function insert_entry()
    {
        $sql ="INSERT INTO `ios`.`event` (`eid`, `ename`, `subject`, `start_time`, `end_time`, `notes`, `location_desc`, `location_latitude`, `location_longitude`, `uid`, `create_time`, `status`, `selected_uid`,`numOfCandidates`) VALUES (NULL, '$this->title', '$this->subject', '$this->startTime', '$this->endTime', '$this->notes', '$this->location', '$this->latitude', '$this->longitude', '$this->creatorID', NOW(), '0', '0','0')";
        $this->db->query($sql);

    }

    function getByStatus($uid,$status)
    {
        //0-coming 1-pending 2-me ,3-unreview 4, reviewed
        if($status == 0)
            $sql = "select * from `event` where (`selected_uid` = '$uid' or `uid` = '$uid') and `status` = '1' and `start_time` > CURRENT_TIMESTAMP order by create_time desc";
        if($status == 1)
            $sql = "select * from `event`, `goEvent` where `enent_id`=`eid` and `apply_uid` = '$uid' and `status` = '0' order by create_time desc";
        if($status == 2)
            $sql = "select * from `event` where `uid` = '$uid' and `status` = '0' order by create_time desc";
        if($status == 3)
            $sql = "select * from `event`
where `eid` not in (select `event_id` as `eid` from `comments` where `commenter_id` = '$uid') and (`event`.`selected_uid` = '$uid' or `event`.`uid` = $uid) and `event`.`status` = '1' and `event`.`start_time` < CURRENT_TIMESTAMP order by `event`.`create_time` desc";
        if($status == 4)
            $sql = "select * from `event`
where `eid` in (select `event_id` as `eid` from `comments` where `commenter_id` = '$uid') and (`event`.`selected_uid` = '$uid' or `event`.`uid` = $uid) and `event`.`status` = '1' and `event`.`start_time` < CURRENT_TIMESTAMP order by `event`.`create_time` desc";
        return $this->db->query($sql);
    }

    function getNotification($uid){
        $sql = "select * from `event` where (`selected_uid` = '$uid' or `uid` = '$uid') and `status` = '1' and `start_time` > CURRENT_TIMESTAMP and `notified` =false order by create_time desc";
        $result = $this->db->query($sql);
        $sql = "UPDATE  `event` SET  `notified` =  '1' WHERE  (`selected_uid` = '$uid' or `uid` = '$uid')";
        $this->db->query($sql);
        return $result;
    }

    function getByCondition($keyword, $sortBy, $subject, $latitude,$longitude)
    {
        //sortby 0 = revlent, 1 = lcoation, 2=rating
        $sql ="";
        $keyword = "%".$keyword."%";

        if($sortBy == 0){ //revenlent
            if($subject != "All"){
                if($keyword == "")
                    $sql = "select * from `event` where `subject` = '$subject' order by create_time desc";
                else
                    $sql = "select * from `event` where `subject` = '$subject' and `ename` like '$keyword' order by create_time desc";
            }
            else if($keyword == "")
                $sql = "select * from `event` order by create_time desc";
            else{
                $sql = "select * from `event` where `ename` like '$keyword' order by create_time desc";
            }
        }
        return $this->db->query($sql);
    }

    function checkTakeEvent($uid, $eventId)
    {
        //check 
        $sql = "SELECT * FROM `goEvent` WHERE `apply_uid` = '$uid' and `enent_id` = '$eventId'";
        return $this->db->query($sql);
    }

    function insertTakeEvent($uid, $eventId)
    {
        //check 
        $sql = "INSERT INTO `goEvent` (`apply_uid`, `enent_id`, `timestamp`) VALUES ('$uid', '$eventId', CURRENT_TIMESTAMP);";
        return $this->db->query($sql);
    }

    function addCandidates($eventId){
        $sql = "UPDATE  `event` SET  `numOfCandidates` = `numOfCandidates` +1  WHERE `eid` = '$eventId'";
        return $this->db->query($sql);
    }
    function candidateList($eventId){
        $sql = "SELECT * FROM `goEvent`, `user` WHERE `uid` =`apply_uid` and `enent_id` ='$eventId'";
        return $this->db->query($sql);
    }

    function applyCandidate($eventId, $candidateId){
        $sql = "UPDATE  `ios`.`event` SET  `status` =  '1', `selected_uid` =  '$candidateId' WHERE  `event`.`eid` ='$eventId'";
        return $this->db->query($sql);

    }

}
?>