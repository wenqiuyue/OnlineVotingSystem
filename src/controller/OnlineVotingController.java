package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import entity.Match;
import entity.ResultMsg;
import entity.User;
import service.OnlineVotingService;

@Controller
public class OnlineVotingController {
	@Autowired
	private OnlineVotingService onlineVotingService;
	
	//进入登录页面
	@RequestMapping("/login")
	public ModelAndView login() {
		ModelAndView mv=new ModelAndView("login");
		return mv;
	}	
	//跳转投票页面
		@RequestMapping("/voteIndex")
		public ModelAndView voteIndex() {
			ModelAndView mv=new ModelAndView("audiencesAndjudges_page/vote_index");
			return mv;
		}
	
	//欢迎界面
	@RequestMapping("/welcome")
	public ModelAndView welcome() {
		ModelAndView mv=new ModelAndView("welcome");
		return mv;
	}
	
	//通过角色类型，获取该类型所有用户
	@RequestMapping("/activityAdministratorList")
	public ModelAndView activityAdministratorList(Integer role) {
		List<User> us=onlineVotingService.getAllActivityAdministrator(role);
		ModelAndView mv=new ModelAndView("system_administrator_page/activity_administrator_list");
		mv.addObject("activityAdministrator", us);
		mv.addObject("role", role);
		return mv;
	}
		
	//添加活动管理人员界面
	@RequestMapping("/addUser")
	public ModelAndView addUser(Integer role) {
		ModelAndView mv=new ModelAndView("add");
		mv.addObject("role", role);
		return mv;
	}
	
	//登录跳转
	@RequestMapping("/login_sub")
	public ModelAndView login_sub(String username,String password) {
		User u=new User();
		u.setUname(username);
		u.setPassword(password);
		User us=onlineVotingService.getUserByNameORIDAndpass(u);
		if(us!=null) {
			ModelAndView mv=null;
			//如果登录用户的类别为0，跳转到系统管理员页面，类别为1，跳转到活动管理员页面，类别为2，跳转到观众和评委页面，
			if(us.getCategory()==0) {
				mv=new ModelAndView("system_administrator_page/system_administrator_index");
				
			}else if(us.getCategory()==1) {
				mv=new ModelAndView("activity_administrator_page/activity_administrator_index");
				
			}else {
				
				Match ma=onlineVotingService.getPlayerAInfo();
				Match mb=onlineVotingService.getPlayerB();
				if(ma!=null&&ma!=null) {
					mv=new ModelAndView("audiencesAndjudges_page/vote_index");
					mv.addObject("matcha", ma);
					mv.addObject("matchb", mb);
					System.out.println(mb.getPlayer().getPname());
				}else {
					mv=new ModelAndView("audiencesAndjudges_page/nogame_show");
				}
				
			}			
			mv.addObject("uname", us.getUname());
			mv.addObject("user", us);
			return mv;
		}else {
			ModelAndView mv=new ModelAndView("login_fail");
			return mv;
		}
	}
	
	//添加用户
	@RequestMapping("/addUser_sub")
	@ResponseBody
	public ResultMsg addUser_sub(String username,String pass,Integer role) {
		User u=new User();
		u.setUname(username);
		u.setPassword(pass);
		u.setCategory(role);
		//如果id不存在
		
			int i=onlineVotingService.addUser(u);
			if(i>0) {
				return new ResultMsg(1,"添加成功"); 				
			}else if(i==-2) {
				return new ResultMsg(2,"用户名已存在");
			}
			return new ResultMsg(0,"添加失败");
	}
	
	//管理员删除用户
	@RequestMapping("/delUser")
	@ResponseBody
	public ResultMsg delUser(String uname) {
		int i=onlineVotingService.systemAdministratorDelUser(uname);
		if(i>0) {
			return new ResultMsg(1,"删除成功");
			
		}else {
			return new ResultMsg(0,"删除失败");
		}
	}
}
