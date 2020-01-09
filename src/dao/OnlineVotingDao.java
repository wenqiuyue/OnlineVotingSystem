package dao;

import java.util.List;

import entity.Match;
import entity.Player;
import entity.PlayerVotes;
import entity.User;
import entity.votes;

public interface OnlineVotingDao {
	User getUserByNameORIDAndpass(User u);
	int addUser(User u);
	List<User> getAllActivityAdministrator(int c);
	int systemAdministratorDelUser(String name);
	int getUserByName(String name);
	int addPlayer(Player p);
	int getPlayerById(String number);
	List<Player> getAllPlayer();
	int delPlayerByNumber(String num);
	Player getPlayerByNumber(String num);
	int updatePlayerByNumber(Player p);
	int addMatch(Match ma);
	List<Match> getAllMatch();
	int delMatchByNumber(int number);
	List<votes> getAllVotes();
	int updateVotes(votes v);
	votes getVotesNumByCategory(votes v);
	int updateIsBegin(Match ma);
	Match getBeginMatch(int i);
	Match getPlayerAInfo();
	Match getPlayerB();
	int addVotePlayer(PlayerVotes p);
	int delVotesByMatchNumber(int num);
	int getPlayerVotesByPlayernumber(String num);
}
