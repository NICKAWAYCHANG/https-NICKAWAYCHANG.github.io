package com.project.BonusPointExchangePlatform.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.dao.GameDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.model.Game;
import com.project.BonusPointExchangePlatform.model.Member;

@Service
@Transactional
public class GameService {

	@Autowired
	private GameDao gameDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	public Member getMemberById(Integer id) {
		Optional<Member> query = memberDao.findById(id);
		if(query.isPresent()) {
			return query.get();
		}
		
		return null;
	}
	
	public void insertGame(Member member, Date update_at) {
		gameDao.insertLogin(member, update_at);
		
//		return gameDao.save(game);
	}
	
	public Game checkSignIn(Integer id,String game_type,String create_at) {
		return gameDao.checkSignIn(id, game_type, create_at);
	}
	
	public List<Game> selectDate(Integer id,String game_type){
		return gameDao.selectDate(id, game_type);
	}
}