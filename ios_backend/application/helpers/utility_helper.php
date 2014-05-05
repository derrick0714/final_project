<?php

define("CSS", base_url().'assets/css');
define("JS", base_url().'assets/js');
define("IMG", base_url().'assets/imgs');
define("ICO", base_url().'assets/ico');
define("VIDEO", base_url().'assets/videos');


function load_template( $p, $name, $data= null){

	$p->load->view('header', $data);
	$p->load->view( $name, $data);
	$p->load->view('footer', $data);
}


?>