package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.OnlineVotingDao;
import entity.Match;
import entity.Player;
import entity.PlayerVotes;
import entity.User;
import entity.votes;

@Service
public class OnlineVotingService {
	@Autowired
	private OnlineVotingDao onlineVotingDao;

	public User getUserByNameORIDAndpass(User u) {
		return onlineVotingDao.getUserByNameORIDAndpass(u);
	}
	
	//����û�
	public int addUser(User u) {
		int i=onlineVotingDao.getUserByName(u.getUname());
		if(i>0) {
			return -2;
		}else {
			return onlineVotingDao.addUser(u);
		}
		
	}
	
	//��������ȡ����������û�
	public List<User> getAllActivityAdministrator(int c){
		return onlineVotingDao.getAllActivityAdministrator(c);
	}
	
	//ϵͳ����Աɾ���û�
	public int systemAdministratorDelUser(String name) {
		return onlineVotingDao.systemAdministratorDelUser(name);
	}
	
	//���ѡ��
	public int addPlayer(Player p) {
		int i=onlineVotingDao.getPlayerById(p.getNumber());
		if(i>0) {
			return -2;
		}else {
			return onlineVotingDao.addPlayer(p);
		}
		
	}
	
	//��ѯ����ѡ��
	public List<Player> getAllPlayer(){
		return onlineVotingDao.getAllPlayer();
	}
	
	//ɾ��ѡ��
	public int delPlayerByNumber(String num) {
		return onlineVotingDao.delPlayerByNumber(num);
	}
	
	//����ѡ�ֱ�Ų���ѡ��
	public Player getPlayerByNumber(String num) {
		return onlineVotingDao.getPlayerByNumber(num);
	}
	
	//����ѡ�ֱ���޸�ѡ����Ϣ
	public int updatePlayerByNumber(Player p) {
		return onlineVotingDao.updatePlayerByNumber(p);
	}
	
	//��ӱ�������
	public int addMatch(Match ma) {
		return onlineVotingDao.addMatch(ma);
	}
	
	//�������б�������
	public List<Match> getAllMatch(){
		return onlineVotingDao.getAllMatch();
	}
	
	//���ݱ�������ɾ���ñ���
	public int delMatchByNumber(int number) {
		return onlineVotingDao.delMatchByNumber(number);
	}
	
	//������ЧͶƱ
	public List<votes> getAllVotes(){
		return onlineVotingDao.getAllVotes();
	}
	
	//������ЧƱ��
	public int updateVotes(votes v) {
		return onlineVotingDao.updateVotes(v);
	}
	
	//��������ѯ��ЧƱ��
	public votes getVotesNumByCategory(votes v) {
		return onlineVotingDao.getVotesNumByCategory(v);
	}
	
	//�޸ı����Ƿ�����
	public int updateIsBegin(Match ma) {
		return onlineVotingDao.updateIsBegin(ma);
	}
	
	//��ȡ�����ı���
	public Match getBeginMatch(int i) {
		return onlineVotingDao.getBeginMatch(i);
	}
	
	//��ȡ����ѡ��a����Ϣ
	public Match getPlayerAInfo() {
		return onlineVotingDao.getPlayerAInfo();
	}
	
	//��ȡ����ѡ��b����Ϣ
	public Match getPlayerB(){
		return onlineVotingDao.getPlayerB();
	}
	
	//������ͶƱ��ѡ�ֱ�ż��뵽���ݿ�
	public int addVotePlayer(PlayerVotes num) {
		return onlineVotingDao.addVotePlayer(num);
	}
	
	//ɾ��ĳ������ͶƱ���
	public int delVotesByMatchNumber(int num) {
		return onlineVotingDao.delVotesByMatchNumber(num);
	}
	
	//��ȡѡ��Ʊ��
	public int getPlayerVotesByPlayernumber(String num) {
		return onlineVotingDao.getPlayerVotesByPlayernumber(num);
	}
	
}
