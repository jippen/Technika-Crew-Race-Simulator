<?php
//This script, ideally, should be moved out of the public web area, and run via cron
include('config.php');
include('technika.class.php');
header('Content-type: text/plain');

$Technika = new Technika($_config['mysql_server'],$_config['mysql_user'],$_config['mysql_pass'],$_config['mysql_db']);
$Technika->startScrape();


$pagenum = 1;
$page = "http://www.djmaxcrew.com/crewrace/crewrace_ing.asp?page=";

for($pagenum=1;$pagenum<10;$pagenum++){

    $html = file_get_contents($page . $pagenum);

    // Specify configuration
    $config = array(
           'indent'         => true,
           'output-xhtml'   => true,
           'wrap'           => 200);

    // Tidy
    $tidy = new tidy;
    $tidy->parseString($html, $config, 'utf8');
    $tidy->cleanRepair();

    //Aplogies for this next block, its a mess, and hard to ever clean up
    $dom = new DOMDocument();
    $dom->loadHTML($tidy);
    $xml = simplexml_import_dom($dom);
    $base = $xml->body->table[1]->tr->td->table[1]->tr[1]->td->table->tr->td->table->tr->td[2]->table->tr[1]->td->table->tr->td->table->tr[1]->td->table;
    unset($base->tr[0]);
    $rows = sizeof($base->tr) / 3;

    for($row=0;$row<$rows;$row++){
	$r1 = $base->tr[$row * 3];
	if((string)$r1->td->span == "Group does not exist in the crew."){die();}
	$r2 = $base->tr[$row * 3 + 1];
	if((string)$r2->td->span == "Not Couse."){continue;}
        $r2 = $r2->td->table->tr;
        $mods = (string)$r2->td[8]->span[0];
        $m = explode('/',implode('/',explode(' : ',$mods)));

        //Yank all the info
	    //$store['current_rank'] = (integer)$r1->td[0]->span;
        $store['rank'] = (integer)$r1->td[6]->table->tr->td[1]->span[1];
        $store['crew_name'] = (string)$r1->td[4]->span[0];
        $store['player_name'] = substr($r2->td[1]->span,2);
        $store['player_icon'] = substr($r2->td[2]->img->attributes()->src,61,-4);
	    $store['emblem_bg'] = substr($r1->td[2]->table->attributes()->background,69,-4);
        $store['emblem_fg'] = substr($r1->td[2]->table->tr->td->img->attributes()->src,71,-4);

        $song = substr($r2->td[3]->img->attributes()->src,63,-4);
        $store['song_1'] = substr($song,0,-2);
        $store['song_1_difficulty'] = substr($song,-1);
        $store['song_1_mod_1'] = $m[0];
        $store['song_1_mod_2'] = $m[1];
        $store['song_1_mod_3'] = $m[2];

        $song = substr($r2->td[5]->img->attributes()->src,63,-4);
        $store['song_2'] = substr($song,0,-2);
        $store['song_2_difficulty'] = substr($song,-1);
        $store['song_2_mod_1'] = $m[3];
        $store['song_2_mod_2'] = $m[4];
        $store['song_2_mod_3'] = $m[5];

        $song = substr($r2->td[7]->img->attributes()->src,63,-4);
        $store['song_3'] = substr($song,0,-2);
        $store['song_3_difficulty'] = substr($song,-1);
        $store['song_3_mod_1'] = $m[6];
        $store['song_3_mod_2'] = $m[7];
        $store['song_3_mod_3'] = $m[8];

        $playwin = explode(':',(string)$r2->td[8]->span[1]);
        $store['play'] = (integer)$playwin[1];
        $store['win'] = (integer)$playwin[2];

        $Technika->scrape($store);
   }
}
