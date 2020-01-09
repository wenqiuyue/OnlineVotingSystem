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
	
	//��תѡ���б����
	@RequestMapping("/playerList")
	public ModelAndView playerList() {
		List<Player> p=onlineVotingService.getAllPlayer();
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_list");
		mv.addObject("player", p);
		return mv;
	}
	
	//��ת���ѡ�ֽ���
	@RequestMapping("/addPlayer")
	public ModelAndView addPlayer() {
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_add");
		return mv;
	}
	
	//��ת�鿴ѡ����Ϣ����
	@RequestMapping("/playerSee")
	public ModelAndView playerSee(String number) {
		Player p=onlineVotingService.getPlayerByNumber(number);
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_see");
		mv.addObject("player", p);		
		return mv;
	}
	
	//��תͶ��
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
	
	//��ת������������
	@RequestMapping("/matchNumber")
	public ModelAndView matchNumber() {
		List<Player> p=onlineVotingService.getAllPlayer();
		List<Match> ma=onlineVotingService.getAllMatch();
		ModelAndView mv=new ModelAndView("activity_administrator_page/match_number");
		mv.addObject("player", p);
		mv.addObject("match", ma);
		return mv;
	}
	
	//��תƱ�����ƽ���
	@RequestMapping("/votes")
	public ModelAndView votes() {
		List<votes> vo=onlineVotingService.getAllVotes();
		ModelAndView mv=new ModelAndView("activity_administrator_page/votes");
		mv.addObject("votes", vo);
		return mv;
	}
	
	//����ѡ�ֱ�Ź���ѡ������
	@RequestMapping("/selectPlayer")
	@ResponseBody
	public ResultMsg selectPlayer(String num) {
		Player p=onlineVotingService.getPlayerByNumber(num);
		/*System.out.println(num);
		ModelAndView m=new ModelAndView("activity_administrator_page/match_number");
		m.addObject("pla", p);*/
		return new ResultMsg(1,p.getPname());
	}
	//���ձ��ύ����
	@RequestMapping("/upload_submit")
	/*��MultipartFile�����ļ���ַ MultipartFile file����Ҫ��jspҳ����ı���nameһ��*/
	public ModelAndView upload_submit(MultipartFile file,HttpServletRequest request) {  
		//�ϴ��ļ���������
			
		//1����ȡ�ļ����ڵ�����·������Ŀ���������ڵ�����springmvc_demo��ַ��/upload/ͼƬ��
		String realPath=request.getServletContext().getRealPath("/");  //��Ŀ�����������ַ
		System.out.println(realPath);
		String filename=file.getOriginalFilename();  //�ļ���+��׺
		String path=realPath+"/upload/"+filename;   //ͼƬ���ڵ�����·��
		//2����������·����װ��File����
		File file1=new File(path);
		//3�������յ����ļ����ݴ��䵽file1�� 
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
		//��ת���ɹ�ҳ��
		ModelAndView mv=new ModelAndView("activity_administrator_page/player_add");
		mv.addObject("filename",filename);  //��ͼƬ·������ҳ��
		return mv;
	}
		
		
	//���ѡ��
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
			return new ResultMsg(1,"��ӳɹ�");
		}else if(i==-2) {
			return new ResultMsg(2,"��ѡ�ֱ���Ѵ���");
		}
		return new ResultMsg(0,"���ʧ��");
	}
	
	//ɾ��ѡ��
	@RequestMapping("/delPlayer")
	@ResponseBody
	public ResultMsg delPlayer(String number) {
		int i=onlineVotingService.delPlayerByNumber(number);
		if(i>0) {
			return new ResultMsg(1,"ɾ���ɹ�");
		}else {
			return new ResultMsg(0,"ɾ��ʧ��");
		}
	}
	
	/*//����ѡ�ֱ���޸�ѡ����Ϣ
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
			return new ResultMsg(1,"�޸ĳɹ�");
		}else {
			return new ResultMsg(0,"�޸�ʧ��");
		}
	}*/
	
	//��ӱ�������
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
			return new ResultMsg(1,"��ӳɹ�");
		}else {
			return new ResultMsg(0,"���ʧ��");
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
	
	//ɾ������
	@RequestMapping("/delMatch")
	@ResponseBody
	public ResultMsg delMatch(Integer num) {
		int i=onlineVotingService.delMatchByNumber(num);
		if(i>0) {
			return new ResultMsg(1,"ɾ���ɹ�");
		}else {
			return new ResultMsg(0,"ɾ��ʧ��");
		}
		
	}
	
	//������ЧƱ��
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
	
	//�޸ı����Ƿ�����
	@RequestMapping("/isBegin")
	@ResponseBody
	public ResultMsg isBegin(Integer number,Integer isbegin) {
		Match ma=new Match();
		ma.setNumber(number);
		ma.setIsbegin(isbegin);
		int i=onlineVotingService.updateIsBegin(ma);
		if(i>0) {
			return new ResultMsg(1,"�޸ĳɹ�");
		}else {
			return new ResultMsg(0,"�޸�ʧ��");
		}
	}
	
	//��ȡ����ѡ����Ϣ
	@RequestMapping("/getPlayer")
	public ModelAndView getPlayer() {
		ModelAndView mv=new ModelAndView("audiencesAndjudges_page/vote_index");
		Match ma=onlineVotingService.getPlayerAInfo();
		Match mb=onlineVotingService.getPlayerB();
		mv.addObject("matcha", ma);
		mv.addObject("matchb", mb);
		return mv;
	}
	
	//��ȡѡ�� 
	  

}
