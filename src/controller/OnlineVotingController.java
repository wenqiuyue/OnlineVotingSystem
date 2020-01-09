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
	
	//�����¼ҳ��
	@RequestMapping("/login")
	public ModelAndView login() {
		ModelAndView mv=new ModelAndView("login");
		return mv;
	}	
	//��תͶƱҳ��
		@RequestMapping("/voteIndex")
		public ModelAndView voteIndex() {
			ModelAndView mv=new ModelAndView("audiencesAndjudges_page/vote_index");
			return mv;
		}
	
	//��ӭ����
	@RequestMapping("/welcome")
	public ModelAndView welcome() {
		ModelAndView mv=new ModelAndView("welcome");
		return mv;
	}
	
	//ͨ����ɫ���ͣ���ȡ�����������û�
	@RequestMapping("/activityAdministratorList")
	public ModelAndView activityAdministratorList(Integer role) {
		List<User> us=onlineVotingService.getAllActivityAdministrator(role);
		ModelAndView mv=new ModelAndView("system_administrator_page/activity_administrator_list");
		mv.addObject("activityAdministrator", us);
		mv.addObject("role", role);
		return mv;
	}
		
	//��ӻ������Ա����
	@RequestMapping("/addUser")
	public ModelAndView addUser(Integer role) {
		ModelAndView mv=new ModelAndView("add");
		mv.addObject("role", role);
		return mv;
	}
	
	//��¼��ת
	@RequestMapping("/login_sub")
	public ModelAndView login_sub(String username,String password) {
		User u=new User();
		u.setUname(username);
		u.setPassword(password);
		User us=onlineVotingService.getUserByNameORIDAndpass(u);
		if(us!=null) {
			ModelAndView mv=null;
			//�����¼�û������Ϊ0����ת��ϵͳ����Աҳ�棬���Ϊ1����ת�������Աҳ�棬���Ϊ2����ת�����ں���ίҳ�棬
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
	
	//����û�
	@RequestMapping("/addUser_sub")
	@ResponseBody
	public ResultMsg addUser_sub(String username,String pass,Integer role) {
		User u=new User();
		u.setUname(username);
		u.setPassword(pass);
		u.setCategory(role);
		//���id������
		
			int i=onlineVotingService.addUser(u);
			if(i>0) {
				return new ResultMsg(1,"��ӳɹ�"); 				
			}else if(i==-2) {
				return new ResultMsg(2,"�û����Ѵ���");
			}
			return new ResultMsg(0,"���ʧ��");
	}
	
	//����Աɾ���û�
	@RequestMapping("/delUser")
	@ResponseBody
	public ResultMsg delUser(String uname) {
		int i=onlineVotingService.systemAdministratorDelUser(uname);
		if(i>0) {
			return new ResultMsg(1,"ɾ���ɹ�");
			
		}else {
			return new ResultMsg(0,"ɾ��ʧ��");
		}
	}
}
