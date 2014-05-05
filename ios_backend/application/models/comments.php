<?php
class Comments extends CI_Model {

    function insert($user_id, $commenter_id, $content, $rating,$eventId)
    {
        $sql ="INSERT INTO `comments` (`user_id`, `commenter_id`, `content`, `timestamp`,`rating`,`event_id`) VALUES ('$user_id', '$commenter_id', '$content', CURRENT_TIMESTAMP,'$rating', '$eventId')";
        $this->db->query($sql);
    }

    function get($user_id)
    {
        $sql ="SELECT * FROM `comments` WHERE `user_id` = '$user_id'";
        return $this->db->query($sql);
    }
}