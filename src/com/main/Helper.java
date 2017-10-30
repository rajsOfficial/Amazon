package com.main;

import java.util.ArrayList;
import java.util.Collections;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.cache.Cache;
import javax.cache.CacheException;
import javax.cache.CacheManager;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@SuppressWarnings("unchecked")
public class Helper<T> {
	
	Cache memCache;
    javax.cache.CacheFactory factory;
    List<ProductPojo> proposedList;
	 protected String checkLogin(String x,String email,String password) throws CacheException{
	
			List<T> ls=null;
			String pwd = null ;
			
			if(x.equals("user")){
				ls = DAO.dataAccess_User(email);
				if (ls.isEmpty()) {
					return  "Email id is not present.";
				}
				pwd=((UserPojo) ls.get(0)).getPassword();
			}
			
			if(x.equals("dealer")){
				ls = DAO.dataAccess_Dealer(email);
				if (ls.isEmpty()) {
					return  "Email id is not present.";
				}
				pwd=((DealerPojo) ls.get(0)).getPassword();
			}

			if (pwd.equals(password)) {
					cache_Initate();
					return "Good";
				}
				else 
					return "Password is wrong";
			}
			
	
	protected String getData_Profile(String field , String cond) throws JsonProcessingException{
		
		List<ProductPojo> ls =DAO.dataAccess_Profile(field, cond);
		Map<String,ProductPojo> map1 = new HashMap<>();
		for(int i=0; i<ls.size();i++){
			map1.put("obj"+i, ls.get(i));
		}
		ObjectMapper mapperObj = new ObjectMapper();
		return mapperObj.writeValueAsString(map1);
		
	}
	
	protected String cart_Helper(String action,String email,long index) throws JsonProcessingException{
		
		List<T> ls=null;
		ls = DAO.dataAccess_User(email);
		UserPojo up = (UserPojo) ls.get(0);
		Map<String,ProductPojo> map1 = new HashMap<>();
		
		if (action.equals("show")) {
			int i = 0;
			Set <Long> productIds = up.getCartid();
			for (Long id : productIds) {
				i++;
				map1.put("obj" + i, DAO.objectById(id));
			}

			return new ObjectMapper().writeValueAsString(map1);
		}
		
		else if(action.equals("add")){
			up.getCartid().add(index);
			DAO.makePersist("user", up);
			return new ObjectMapper().writeValueAsString("Added To Cart");
		}
		
		
		else if(action.equals("remove")){
			up.getCartid().remove(index);
			DAO.makePersist("user", up);
			return new ObjectMapper().writeValueAsString("Removed From Cart");
		}
		return "";
	}
	
	
	protected String admin_Helper(long id, String func) throws JsonProcessingException{
		
		ProductPojo prodObj = DAO.objectById(id);
		if(func.equals("add")){
			
			prodObj.setType("User");
			DAO.makePersist("product",prodObj);
			return  new ObjectMapper().writeValueAsString("Added Successfully");
		}
		else {
			
			DAO.deletePersist("product",prodObj);
			return new ObjectMapper().writeValueAsString("Deleted Successfully");
	}
}


	protected String proposal_Helper(String productName, long price, long quantity, long discount,String dealerEmail) throws JsonProcessingException{
		Map<String, String> map = new HashMap<>();
		map.put("ans", "Sent to Admin for approval");
		ProductPojo obj = new ProductPojo();
		obj.setProductname(productName);
		obj.setPrice(price);
		obj.setQuantity(quantity);
		obj.setDiscount(discount);
		obj.setType("Dealer");
		obj.setDealeremail(dealerEmail);
		DAO.makePersist("product", obj);
		proposedList.add(obj);
		memCache.put(1, proposedList);
		
		return new ObjectMapper().writeValueAsString(map);
	}


	protected void cache_Initate() throws CacheException {
		factory = CacheManager.getInstance().getCacheFactory();
		memCache = factory.createCache(Collections.emptyMap());
		proposedList = new ArrayList<>();
	}
	
	protected void output(long id, int quan){
		
		ProductPojo prodObj = (ProductPojo) DAO.objectById(id);
		if((prodObj.getQuantity() - quan)==0){
			DAO.deletePersist("product", prodObj);
		}
		else{
		prodObj.setQuantity((prodObj.getQuantity() - quan));
			DAO.makePersist("product", prodObj);
		}
	}
	
	protected String todayProposal() throws JsonProcessingException{
		 List<ProductPojo> todayProposal =null;
		 Map<String,ProductPojo> map1 = new HashMap<>();
		 try{	
		  todayProposal =  (List<ProductPojo>) memCache.get(2);
		  if(!todayProposal.isEmpty()){
				for(int i=0; i<todayProposal.size();i++){
					map1.put("obj"+i, todayProposal.get(i));
				}
				ObjectMapper mapperObj = new ObjectMapper();
				return mapperObj.writeValueAsString(map1);
				}
		}
		catch(NullPointerException e){
			return "empty";
		}
			return "empty";
	}
	
	protected void taskHandler(){ 
		
		List<ProductPojo> ls = DAO.dataAccess_Profile("type", "Dealer");
		for(int i=0; i<ls.size();i++){
			DAO.deletePersist("product", ls.get(i));
		}
	}

	protected String delivery(long id) throws JsonProcessingException{
		ProductPojo obj =DAO.objectById(id);
		return new ObjectMapper().writeValueAsString(obj);
	}
	
	protected boolean googleLogin(String gEmail, String name) throws JsonProcessingException{

			List<UserPojo> ls = DAO.dataAccess_User(gEmail);
			if(ls.isEmpty()){
				UserPojo userObj = new UserPojo();
				userObj.setEmail(gEmail);
				userObj.setFirstname(name);
				DAO.makePersist("user", userObj);
			}
			return true;
		
	}


	protected String userSignUp(String fname, String lname, String email, long number, String password) {
		
		String response ;
		List<UserPojo> ls = DAO.dataAccess_User(email);
			if(ls.isEmpty()){
				if(number>=1000000000 && number <= 9999999999L){
					
					DAO.userPersist(fname,lname,email,number,password);
					response ="Good";
				}
				else{
					response="Given Phone Number is not a valid one";
				}
			}
			else{
			 response="Email id already present";
			}	
		return response;	
	}

protected String dealerSignUp(String name, String email, long number, String password) {
	
	String response ;
	List<UserPojo> ls = DAO.dataAccess_Dealer(email);
		if(ls.isEmpty()){
			if(number>=1000000000 && number <= 9999999999L){
				
				DAO.dealerPersist(name,email,number,password);
				response ="Good";
			}
			else{
				response="Given Phone Number is not a valid one";
			}
		}
		else{
		 response="Email id already present";
		}	
	return response;	
}
}
