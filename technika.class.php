<?php
class Technika
{
    public $db; //Storage for DB connector
    public $difficulty = array("?","NM","HD","MX","EX");

    public function __construct($server,$user,$pass,$db){
        $this->db = new mysqli($server,$user,$pass,$db);
        if ($this->db->connect_error) {
            die('Connect Error (' . $this->db->connect_errno . ') '.$this->db->connect_error);
        }	
    }

    public function load_songs(){
        //Cacheing functions! Yay!
	if(!empty($this->songs)){return;}
        $res = $this->db->query("SELECT * FROM songs");
	while($aSongs = $res->fetch_row()){
		$this->songs[$aSongs[0]] = array($aSongs[1],$aSongs[2],$aSongs[3],$aSongs[4]);
        }
    }

    //output HTML presenting a crew emblem
    public function gui_crew($bg,$fg,$name){
	$bg_img = 'http://images.djmaxcrew.com/Technika2/EN/icon/technika2/emblem/plate/'.$bg.'.png';
        $fg_img = 'http://images.djmaxcrew.com/Technika2/EN/icon/technika2/emblem/pattern/'.$fg.'.png';
        $this->printi(3,'<tr>');
        $this->printi(4,'<td>');
        $this->printi(5,'<table class="emblem">');
        $this->printi(6,'<tr>');
        $this->printi(7,'<td class="emblem" background="'.$bg_img.'">');
        $this->printi(8,'<img src="'.$fg_img.'"/>');
        $this->printi(7,'</td>');
        $this->printi(6,'</tr>');
        $this->printi(5,'</table>');
        $this->printi(4,'</td>');
        $this->printi(4,'<td>'.$name.'</td>');
        $this->printi(3,'</tr>');
        
    }

    public function gui_player($pi,$name){
        $pi_img = 'http://images.djmaxcrew.com/Technika2/EN/icon/technika2/icon/'.$pi.'.png';
        $this->printi(3,'<tr>');
        $this->printi(4,'<td>');
        $this->printi(5,'<img src="'.$pi_img.'"/>');
        $this->printi(4,'</td>');
        $this->printi(4,'<td>'.$name.'</td>');
        $this->printi(3,'</tr>');
    }

    //Prints the disc image
    public function gui_song($song,$difficulty,$mod1,$mod2,$mod3,$size='m'){
        $this->printi(2,'<td class="disc" width="110">');
	$img = sprintf('http://images.djmaxcrew.com/Technika2/EN/icon/technika2/disc_%s/%s_%s.png',$size,$song,$difficulty);
	$this->printi(3,'<img class="disc" src="'.$img.'"/>');
	$this->printi(3,'<p class="songname">'.$this->songs[$song][0].'</p>');
        $this->printi(3,'<p class="difficulty">'.$this->difficulty[$difficulty].' - '.$this->songs[$song][$difficulty].'</p>');
	//$base = '<img src="img/%s.png"/>';
        $base = '%s';
        $m1 = sprintf($base,$mod1);
	$m2 = sprintf($base,$mod2);
        $m3 = sprintf($base,$mod3);
	$this->printi(3,'<p class="mods">'.$m1.'/'.$m2.'/'.$m3.'</p>');
	$this->printi(2,'</td>');
    }

    //Prints out the race table
    public function gui_race(){
        $this->load_songs();
	$res = $this->db->query("SELECT * FROM race ORDER BY rank LIMIT 90");
        $this->printi(0,'<table class="crewrace" border="0" cellpadding="0" cellspacing="0">');
        $this->printi(1,'<tr>');
        $this->printi(2,'<th>Rank</th>');
        $this->printi(2,'<th>&nbsp;</th>');
        $this->printi(2,'<th>Song 1</th>');
        $this->printi(2,'<th>Song 2</th>');
        $this->printi(2,'<th>Song 3</th>');
        $this->printi(2,'<th>Plays</th>');
        $this->printi(2,'<th>Wins</th>');
        $this->printi(2,'<th>Win%</th>');
        $this->printi(1,'</tr>');
        $i = 1;
        while($race = $res->fetch_assoc()){
            $this->gui_race_row($race,$i++);
        }
        $this->printi(0,'</table>');
     }

    //Output a race row
    public function gui_race_row($race_arr,$index){
        if($index % 2){
	    $this->printi(1,'<tr>');
        }else{
            $this->printi(1,'<tr class="odd">');
        }
	$this->printi(2,'<td class="rank">'.$index.'</td>');
        $this->printi(2,'<td><table>');
	$this->gui_crew($race_arr['emblem_bg'],$race_arr['emblem_fg'],$race_arr['crew_name']);
        $this->gui_player($race_arr['player_icon'],$race_arr['player_name']);
        $this->printi(2,'</table></td>');
	$this->gui_song($race_arr['song_1'],$race_arr['song_1_difficulty'],$race_arr['song_1_mod_1'],$race_arr['song_1_mod_2'],$race_arr['song_1_mod_3']);
        $this->gui_song($race_arr['song_2'],$race_arr['song_2_difficulty'],$race_arr['song_2_mod_1'],$race_arr['song_2_mod_2'],$race_arr['song_2_mod_3']);
        $this->gui_song($race_arr['song_3'],$race_arr['song_3_difficulty'],$race_arr['song_3_mod_1'],$race_arr['song_3_mod_2'],$race_arr['song_3_mod_3']);
        $this->printi(2,'<td>'.$race_arr['play'].'</td>');
	$this->printi(2,'<td>'.$race_arr['win'].'</td>');
	$rate = 0;
	if($race_arr['play'] >0){$rate = round($race_arr['win'] / $race_arr['play'] * 100); }
	$this->printi(2,'<td>'.$rate.'%</td>');
        $this->printi(1,'</tr>');
    }

    public function printi($indent,$str){
        while($indent--){ print("    ");}
        print($str."\n");
	}

    public function startScrape(){
        $this->db->query("TRUNCATE TABLE race");
        $sql  = "INSERT INTO ";
        $sql .= "    race";
        $sql .= " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $this->prepared = $this->db->prepare($sql);
        if($this->prepared === false){
            die('Prepared query for race insertion failed. ' . $this->db->error);
        }
    }

    public function scrape($a){
       $this->prepared->bind_param("sssssssssssssssssssssss",
           $a['rank'],
           $a['crew_name'],
           $a['player_name'],
           $a['player_icon'],
           $a['emblem_bg'],
           $a['emblem_fg'],
           $a['song_1'],
           $a['song_1_difficulty'],
           $a['song_1_mod_1'],
           $a['song_1_mod_2'],
           $a['song_1_mod_3'],
           $a['song_2'],
           $a['song_2_difficulty'],
           $a['song_2_mod_1'],
           $a['song_2_mod_2'],
           $a['song_2_mod_3'],
           $a['song_3'],
           $a['song_3_difficulty'],
           $a['song_3_mod_1'],
           $a['song_3_mod_2'],
           $a['song_3_mod_3'],
           $a['play'],
           $a['win']);
       $this->prepared->execute();
       if($this->db->error){
           print_r($a);
           print('The above data caused this error: ' . $this->db->error);
       } 
    }
}
