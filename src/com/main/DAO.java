package com.main;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

@SuppressWarnings("rawtypes")
public class DAO {

	static PersistenceManager pm = PMF.get().getPersistenceManager();
	static Transaction tx = pm.currentTransaction();

	protected static List dataAccess_User(String email) {
		try{
		tx.begin();
		Query q = pm.newQuery(UserPojo.class, "email==Email");
		q.declareParameters("String Email");
		return (List) q.execute(email);
		}
		finally{
			tx.commit();
			if(tx.isActive())
				tx.rollback();
		}
	}

	protected static List dataAccess_Dealer(String email) {
		Query q = pm.newQuery(DealerPojo.class, "email==Email");
		q.declareParameters("String Email");
		return (List) q.execute(email);
	}

	protected static List dataAccess_Profile(String field, String cond) {

		Query q = pm.newQuery(ProductPojo.class, field + "==detail");
		q.declareParameters("String detail");
		return (List) q.execute(cond); 
	}

	protected static ProductPojo objectById(long id) {
		return pm.getObjectById(ProductPojo.class, id);
	}

	protected static void makePersist(String pojoName, Object obj) {
		if (pojoName.equals("user")) {
			tx.begin();
			UserPojo object = (UserPojo) obj;
			pm.makePersistent(object);
			tx.commit();
		}

		else if (pojoName.equals("dealer")) {
			DealerPojo object = (DealerPojo) obj;
			pm.makePersistent(object);
		} else {
			ProductPojo object = (ProductPojo) obj;
			pm.makePersistent(object);
		}
	}
	
	protected static void deletePersist(String pojoName, Object obj) {
		if (pojoName.equals("user")) {
			UserPojo object = (UserPojo) obj;
			pm.deletePersistent(object);
		}
		else if (pojoName.equals("dealer")) {
			DealerPojo object = (DealerPojo) obj;
			pm.deletePersistent(object);
		} else {
			ProductPojo object = (ProductPojo) obj;
			pm.deletePersistent(object);
		}
	}

	protected static void deliveryPersist(String email, long id, int quan, long phone, String addr,boolean x) {
			DeliveryPojo deliveryObj = new DeliveryPojo(id,phone,quan,addr,email,x);
			try{
				tx.begin();
				pm.makePersistent(deliveryObj);
				}
				finally{
					tx.commit();
					if(tx.isActive())
						tx.rollback();
				}

	}
	
	protected static void userPersist(String fname, String lname, String email, long number, String password){
		UserPojo obj = new UserPojo(fname,lname,email,number,password);
		makePersist("user",obj);
	}

	protected static void dealerPersist(String name, String email, long number, String password) {
		DealerPojo obj = new DealerPojo(name,number,email,password);
		makePersist("dealer",obj);
	}
			
}
