package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import entity.Match;
import entity.PlayerVotes;
import entity.ResulrInt;
import entity.ResultMsg;
import entity.votes;
import service.OnlineVotingService;

@Controller
public class AudiencesAndjudgesController {
	@Autowired
	private OnlineVotingService onlineVotingService;
	
	//�������ע�����
	@RequestMapping("/register")
	public ModelAndView register() {
		ModelAndView mv=new ModelAndView("audiencesAndjudges_page/audiencesAndjudges_register");
		return mv;
	}
	
	//�����û�����ѯ��ЧƱ��
	@RequestMapping("/votesNum")
	@ResponseBody
	public ResulrInt votesNum(Integer usercategory) {
		votes v=new votes();
		v.setUsercategory(usercategory);
		votes votes=onlineVotingService.getVotesNumByCategory(v);
		System.out.println(votes.getVotesnum());
		return new ResulrInt(1,votes.getVotesnum());
	}
	
	//��ȡ�����ı���
	@RequestMapping("/getBegin")
	@ResponseBody
	public ResulrInt getBegin() {
		Match ma=onlineVotingService.getBeginMatch(1);		
		if(ma!=null) {
			//System.out.println(ma.getNumber());
			return new ResulrInt(1,ma.getNumber());
		}else {
			return new ResulrInt(0,0);
		}
		
	}
	
	//������ͶƱ��ѡ�ֱ�ż��뵽���ݿ�
	@RequestMapping("/addVotesPlayer")
	@ResponseBody
	public ResultMsg addVotesPlayer(String num,Integer matchnumber) {
		PlayerVotes plv=new PlayerVotes();
		plv.setMatchnumber(matchnumber);
		plv.setPlayernumber(num);
		int i=onlineVotingService.addVotePlayer(plv);
		if(i>0) {
			return new ResultMsg(1,"ͶƱ�ɹ�");
		}else {
			return new ResultMsg(2,"ͶƱʧ��");
		}
	}
	
	//ɾ��ĳ������ͶƱ���
	@RequestMapping("/delMatchVotes")
	@ResponseBody
	public ResultMsg delMatchVotes(Integer matchnum) {
		int i=onlineVotingService.delVotesByMatchNumber(matchnum);
		if(i>0) {
			return new ResultMsg(1,"ɾ���ɹ�");
		}else {
			return new ResultMsg(2,"ɾ��ʧ��");
		}
	}
		
		
}
