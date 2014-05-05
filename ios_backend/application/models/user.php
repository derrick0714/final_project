<?php
class User extends CI_Model {

    var $_userName   = '';
    var $_passWord   = '';


    function search_entry($userName, $passWord)
    {
        $sql = "select * from `user` where uname = '$userName' and upassword = '$passWord' order by timestamp desc";
        return $this->db->query($sql);
    }

    function getUserInfo($uid)
    {
        $sql = "select * from `user` where uid = '$uid' order by timestamp desc";
        return $this->db->query($sql);
    }

    function searchByName($userName)
    {
        $sql = "select * from `user` where uname = '$userName' order by timestamp desc";
        return $this->db->query($sql);
    }

    function addUser($user, $pwd, $gender)
    {
        $sql = "INSERT INTO `user` (`uid`, `uname`, `upassword`, `timestamp`, `gender`) VALUES (NULL, '$user', '$pwd', NOW(), '$gender')";
        return $this->db->query($sql);
    }

    function updatePhoto($uid, $photo)
    {
        $sql = "UPDATE `user` SET  `photo` = `$photo`  WHERE `uid` = '$uid'";
        return $this->db->query($sql);
    }

}
?>