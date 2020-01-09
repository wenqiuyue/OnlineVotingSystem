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
	
	//添加用户
	public int addUser(User u) {
		int i=onlineVotingDao.getUserByName(u.getUname());
		if(i>0) {
			return -2;
		}else {
			return onlineVotingDao.addUser(u);
		}
		
	}
	
	//根据类别获取该类别所有用户
	public List<User> getAllActivityAdministrator(int c){
		return onlineVotingDao.getAllActivityAdministrator(c);
	}
	
	//系统管理员删除用户
	public int systemAdministratorDelUser(String name) {
		return onlineVotingDao.systemAdministratorDelUser(name);
	}
	
	//添加选手
	public int addPlayer(Player p) {
		int i=onlineVotingDao.getPlayerById(p.getNumber());
		if(i>0) {
			return -2;
		}else {
			return onlineVotingDao.addPlayer(p);
		}
		
	}
	
	//查询所有选手
	public List<Player> getAllPlayer(){
		return onlineVotingDao.getAllPlayer();
	}
	
	//删除选手
	public int delPlayerByNumber(String num) {
		return onlineVotingDao.delPlayerByNumber(num);
	}
	
	//根据选手编号查找选手
	public Player getPlayerByNumber(String num) {
		return onlineVotingDao.getPlayerByNumber(num);
	}
	
	//根据选手编号修改选手信息
	public int updatePlayerByNumber(Player p) {
		return onlineVotingDao.updatePlayerByNumber(p);
	}
	
	//添加比赛场次
	public int addMatch(Match ma) {
		return onlineVotingDao.addMatch(ma);
	}
	
	//查找所有比赛场次
	public List<Match> getAllMatch(){
		return onlineVotingDao.getAllMatch();
	}
	
	//根据比赛场次删除该比赛
	public int delMatchByNumber(int number) {
		return onlineVotingDao.delMatchByNumber(number);
	}
	
	//查找有效投票
	public List<votes> getAllVotes(){
		return onlineVotingDao.getAllVotes();
	}
	
	//更改有效票数
	public int updateVotes(votes v) {
		return onlineVotingDao.updateVotes(v);
	}
	
	//根据类别查询有效票数
	public votes getVotesNumByCategory(votes v) {
		return onlineVotingDao.getVotesNumByCategory(v);
	}
	
	//修改比赛是否启动
	public int updateIsBegin(Match ma) {
		return onlineVotingDao.updateIsBegin(ma);
	}
	
	//获取开启的比赛
	public Match getBeginMatch(int i) {
		return onlineVotingDao.getBeginMatch(i);
	}
	
	//获取比赛选手a的信息
	public Match getPlayerAInfo() {
		return onlineVotingDao.getPlayerAInfo();
	}
	
	//获取比赛选手b的信息
	public Match getPlayerB(){
		return onlineVotingDao.getPlayerB();
	}
	
	//将观众投票的选手编号加入到数据库
	public int addVotePlayer(PlayerVotes num) {
		return onlineVotingDao.addVotePlayer(num);
	}
	
	//删除某场比赛投票结果
	public int delVotesByMatchNumber(int num) {
		return onlineVotingDao.delVotesByMatchNumber(num);
	}
	
	//获取选手票数
	public int getPlayerVotesByPlayernumber(String num) {
		return onlineVotingDao.getPlayerVotesByPlayernumber(num);
	}
	
}
