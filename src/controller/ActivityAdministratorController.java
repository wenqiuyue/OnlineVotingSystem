package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import entity.Match;
import entity.Player;
import entity.ResultMsg;
import entity.votes;
import service.OnlineVotingService;
import sun.text.normalizer.NormalizerBase.Mode;

@Controller
public class ActivityAdministratorController {
	@Autowired
	private OnlineVotingService onlineVotingService;
	
	//跳转选手列表界面
	@RequestMapping("/playerList")
	public ModelAndView playerList() {
		List<Player> p=onlineVotingService.getAllPlayer();
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_list");
		mv.addObject("player", p);
		return mv;
	}
	
	//跳转添加选手界面
	@RequestMapping("/addPlayer")
	public ModelAndView addPlayer() {
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_add");
		return mv;
	}
	
	//跳转查看选手信息界面
	@RequestMapping("/playerSee")
	public ModelAndView playerSee(String number) {
		Player p=onlineVotingService.getPlayerByNumber(number);
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_see");
		mv.addObject("player", p);		
		return mv;
	}
	
	//跳转投屏
	@RequestMapping("/large")
	public ModelAndView large() {
		Match ma=onlineVotingService.getPlayerAInfo();
		Match mb=onlineVotingService.getPlayerB();
		if(ma!=null&&mb!=null) {
		int conta=onlineVotingService.getPlayerVotesByPlayernumber(ma.getPlayer_a_num());
		int contb=onlineVotingService.getPlayerVotesByPlayernumber(ma.getPlayer_b_num());
		ModelAndView mv=new ModelAndView("activity_administrator_page/large_screen");
		mv.addObject("matcha", ma);
		mv.addObject("matchb", mb);
		mv.addObject("conta", conta);
		mv.addObject("contb", contb);
		return mv;
		}else {
			ModelAndView mv=new ModelAndView("activity_administrator_page/votes_show");
			return mv;
		}
	}
	
	//跳转比赛场次设置
	@RequestMapping("/matchNumber")
	public ModelAndView matchNumber() {
		List<Player> p=onlineVotingService.getAllPlayer();
		List<Match> ma=onlineVotingService.getAllMatch();
		ModelAndView mv=new ModelAndView("activity_administrator_page/match_number");
		mv.addObject("player", p);
		mv.addObject("match", ma);
		return mv;
	}
	
	//跳转票数控制界面
	@RequestMapping("/votes")
	public ModelAndView votes() {
		List<votes> vo=onlineVotingService.getAllVotes();
		ModelAndView mv=new ModelAndView("activity_administrator_page/votes");
		mv.addObject("votes", vo);
		return mv;
	}
	
	//根据选手编号关联选手姓名
	@RequestMapping("/selectPlayer")
	@ResponseBody
	public ResultMsg selectPlayer(String num) {
		Player p=onlineVotingService.getPlayerByNumber(num);
		/*System.out.println(num);
		ModelAndView m=new ModelAndView("activity_administrator_page/match_number");
		m.addObject("pla", p);*/
		return new ResultMsg(1,p.getPname());
	}
	//接收表单提交请求
	@RequestMapping("/upload_submit")
	/*用MultipartFile接收文件地址 MultipartFile file名字要和jsp页面的文本框name一致*/
	public ModelAndView upload_submit(MultipartFile file,HttpServletRequest request) {  
		//上传文件到服务器
			
		//1、获取文件所在的物理路径（项目服务器所在的物理（springmvc_demo地址）/upload/图片）
		String realPath=request.getServletContext().getRealPath("/");  //项目服务器物理地址
		System.out.println(realPath);
		String filename=file.getOriginalFilename();  //文件名+后缀
		String path=realPath+"/upload/"+filename;   //图片所在的物理路径
		//2、根据物理路径包装成File对象
		File file1=new File(path);
		//3、将接收到的文件内容传输到file1中 
		if(!file1.getParentFile().exists()) {
			file1.getParentFile().mkdirs();
		}
		try {
			file.transferTo(file1);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//跳转到成功页面
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_add");
		mv.addObject("filename",filename);  //将图片路径传到页面
		return mv;
	}
		
		
	//添加选手
	@RequestMapping("/addPlayer_sub")
	@ResponseBody
	public ResultMsg addPlayer_sub(String picsrc,String username,String number,Integer sex,String phone,String em,String address) {
		Player p=new Player();
		p.setPhotos(picsrc);
		p.setPname(username);
		p.setNumber(number);
		p.setPsex(sex);
		p.setPhone(phone);
		p.setEmail(em);
		p.setAddress(address);
		int i=onlineVotingService.addPlayer(p);
		if(i>0) {
			return new ResultMsg(1,"添加成功");
		}else if(i==-2) {
			return new ResultMsg(2,"该选手编号已存在");
		}
		return new ResultMsg(0,"添加失败");
	}
	
	//删除选手
	@RequestMapping("/delPlayer")
	@ResponseBody
	public ResultMsg delPlayer(String number) {
		int i=onlineVotingService.delPlayerByNumber(number);
		if(i>0) {
			return new ResultMsg(1,"删除成功");
		}else {
			return new ResultMsg(0,"删除失败");
		}
	}
	
	/*//根据选手编号修改选手信息
	@RequestMapping("/updatePlayer_sub")
	@ResponseBody
	public ResultMsg updatePlayer_sub(String username,String number,String phone,String em,String address) {
		Player p=new Player();
		p.setPname(username);
		p.setNumber(number);
		p.setPhone(phone);
		p.setEmail(em);
		p.setAddress(address);
		System.out.println(username+" "+number+" "+phone+" "+em+" "+address);
		int i=onlineVotingService.updatePlayerByNumber(p);
		if(i>0) {
			return new ResultMsg(1,"修改成功");
		}else {
			return new ResultMsg(0,"修改失败");
		}
	}*/
	
	//添加比赛场次
	@RequestMapping("/addMatch")
	public ModelAndView addMatch(Integer matchnumber,String interest,String p_a_program,String interestb,String p_b_program) {
		Match ma=new Match();
		ma.setNumber(matchnumber);
		ma.setPlayer_a_num(interest);
		ma.setPlayer_a_program(p_a_program);
		ma.setPlayer_b_num(interestb);
		ma.setPlayer_b_program(p_b_program);	
		int k=onlineVotingService.addMatch(ma);
		/*if(k>0) {
			List<Match> mat=onlineVotingService.getAllMatch();
			return new ResultMsg(1,"添加成功");
		}else {
			return new ResultMsg(0,"添加失败");
		}*/
		ModelAndView mv=null;
		if(k>0) {
			List<Match> mat=onlineVotingService.getAllMatch();
			mv=new ModelAndView("activity_administrator_page/match_number");
			mv.addObject("match", mat);
			return mv;
		}
		return mv;
	}
	
	//删除比赛
	@RequestMapping("/delMatch")
	@ResponseBody
	public ResultMsg delMatch(Integer num) {
		int i=onlineVotingService.delMatchByNumber(num);
		if(i>0) {
			return new ResultMsg(1,"删除成功");
		}else {
			return new ResultMsg(0,"删除失败");
		}
		
	}
	
	//更改有效票数
	@RequestMapping("/updateVotes")
	public ModelAndView updateVotes(Integer usercategory,Integer votesnum) {
		votes v=new votes();
		v.setUsercategory(usercategory);
		v.setVotesnum(votesnum);
		int i=onlineVotingService.updateVotes(v);
		if(i>0) {
			List<votes> vo=onlineVotingService.getAllVotes();
			ModelAndView mv=new ModelAndView("activity_administrator_page/votes");
			mv.addObject("votes", vo);
			return mv;
		}else {
			ModelAndView mv=new ModelAndView("activity_administrator_page/votes");
			return mv;
		}
		
	}
	
	//修改比赛是否启动
	@RequestMapping("/isBegin")
	@ResponseBody
	public ResultMsg isBegin(Integer number,Integer isbegin) {
		Match ma=new Match();
		ma.setNumber(number);
		ma.setIsbegin(isbegin);
		int i=onlineVotingService.updateIsBegin(ma);
		if(i>0) {
			return new ResultMsg(1,"修改成功");
		}else {
			return new ResultMsg(0,"修改失败");
		}
	}
	
	//获取比赛选手信息
	@RequestMapping("/getPlayer")
	public ModelAndView getPlayer() {
		ModelAndView mv=new ModelAndView("audiencesAndjudges_page/vote_index");
		Match ma=onlineVotingService.getPlayerAInfo();
		Match mb=onlineVotingService.getPlayerB();
		mv.addObject("matcha", ma);
		mv.addObject("matchb", mb);
		return mv;
	}
	
	//获取选手 
	  

}
