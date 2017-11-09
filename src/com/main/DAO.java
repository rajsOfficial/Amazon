package com.main;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.Transaction;

@SuppressWarnings("rawtypes")
public class DAO {

	static PersistenceManager pm = PMF.get().getPersistenceManager();
	static Transaction tx = pm.currentTransaction();

	@SuppressWarnings("unchecked")
	protected static List dataAccess_User(String email) {
		try {
			tx.begin();
			Query q = pm.newQuery(UserPojo.class, "email==Email");
			q.declareParameters("String Email");
			List<UserPojo> ls = (List<UserPojo>) q.execute(email);
			tx.commit();
			return ls;
		} finally {
			if (tx.isActive())
				tx.rollback();
		}
	}

	@SuppressWarnings("unchecked")
	protected static List dataAccess_Dealer(String email) {
		try {
			tx.begin();
			Query q = pm.newQuery(DealerPojo.class, "email==Email");
			q.declareParameters("String Email");
			List<DealerPojo> ls = (List<DealerPojo>) q.execute(email);
			tx.commit();
			return ls;
		} finally {

			if (tx.isActive())
				tx.rollback();
		}
	}
	
	protected static DealerPojo dataAccess_DealerById(String email) {
		try{
		return pm.getObjectById(DealerPojo.class, email);
	}
	catch(Exception e){
		return null;
	}
}

	protected static UserPojo dataAccess_UserById(String email) {
		try{
		return pm.getObjectById(UserPojo.class, email);
		}
		catch(Exception e){
			return null;
		}
}

	@SuppressWarnings("unchecked")
	protected static List dataAccess_Profile(String field, String cond) {

		try {
			tx.begin();
			Query q = pm.newQuery(ProductPojo.class, field + "==detail");
			q.declareParameters("String detail");
			List<ProductPojo> ls = (List<ProductPojo>) q.execute(cond);
			tx.commit();
			return ls;
		} finally {

			if (tx.isActive())
				tx.rollback();
		}
	}

	protected static ProductPojo objectById(long id) {
		return pm.getObjectById(ProductPojo.class, id);
	}

	protected static void makePersist(String pojoName, Object obj) {
		tx.begin();
		if (pojoName.equals("user")) {
			UserPojo object = (UserPojo) obj;
			pm.makePersistent(object);
		}

		else if (pojoName.equals("dealer")) {
			DealerPojo object = (DealerPojo) obj;
			pm.makePersistent(object);
		} else {
			ProductPojo object = (ProductPojo) obj;
			pm.makePersistent(object);
		}
		tx.commit();
	}

	protected static void deletePersist(String pojoName, Object obj) {
		tx.begin();
		if (pojoName.equals("user")) {
			UserPojo object = (UserPojo) obj;
			pm.deletePersistent(object);
		} else if (pojoName.equals("dealer")) {
			DealerPojo object = (DealerPojo) obj;
			pm.deletePersistent(object);
		} else {
			ProductPojo object = (ProductPojo) obj;
			pm.deletePersistent(object);
		}
		tx.commit();
	}

	protected static void deliveryPersist(String email, long id, int quan, long phone, String addr, boolean x) {
		DeliveryPojo deliveryObj = new DeliveryPojo(id, phone, quan, addr, email, x);
		try {
			tx.begin();
			pm.makePersistent(deliveryObj);
			tx.commit();
		} finally {
			if (tx.isActive())
				tx.rollback();
		}

	}

	protected static void userPersist(String fname, String lname, String email, long number, String password) {
		UserPojo obj = new UserPojo(fname, lname, email, number, password);
		makePersist("user", obj);
	}

	protected static void dealerPersist(String name, String email, long number, String password) {
		DealerPojo obj = new DealerPojo(name, number, email, password);
		makePersist("dealer", obj);
	}

}
