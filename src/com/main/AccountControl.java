package com.main;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.auth.openidconnect.IdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import javax.cache.CacheException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountControl {
	private static final HttpTransport UrlFetchTransport = null;

	/*
	 * long userCount =0; long proposalCount=0; long deliveryCount=0; long
	 * totalAmount=0; long totalDiscount=0;
	 */
	@SuppressWarnings("rawtypes")
	Helper helpObj = new Helper();

	@RequestMapping("/")
	public ModelAndView home() {
		return new ModelAndView("index");
	}

	
	@RequestMapping(value="/UserSignup",method=RequestMethod.POST)
	public String UserSignp(@RequestBody String signup,HttpServletRequest  req, HttpServletResponse res) throws IOException{
		
		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, Object> map1 = objectmapper.readValue(signup, new TypeReference<Map<String, Object>>() {
		});

		String email=(String) map1.get("email");
		String password =(String) map1.get("pwd");
		String fname=(String) map1.get("fname");
		String lname=(String) map1.get("lname");
		long number= Long.parseLong((String) map1.get("number"));
		
		 return helpObj.userSignUp(fname,lname,email,number,password);
		 
	}
	
	@RequestMapping(value = "/UserLogin", method = RequestMethod.POST)
	@ResponseBody
	public String useracc(@RequestBody String login, HttpServletRequest req, HttpServletResponse res)
			throws JSONException, CacheException, IOException {

		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, String> map = new HashMap<>();
		Map<String, Object> map1 = objectmapper.readValue(login, new TypeReference<Map<String, Object>>() {
		});

		String email = (String) map1.get("email");
		String ans = (helpObj.checkLogin("user", email, (String) map1.get("password"))).trim();
		if (ans.equals("Good")) {
			HttpSession htp = req.getSession();
			htp.setAttribute("useremail", email);
		}
		map.put("ans", ans);
		return objectmapper.writeValueAsString(map);
	}

	
	
	
	
	@RequestMapping(value = "/UserGoogleLogin", method = RequestMethod.POST)
	@ResponseBody
	public String usergoogleAcc(@RequestBody String login,HttpServletRequest req, HttpServletResponse res)
			throws JsonParseException, IOException, JsonMappingException, JSONException, GeneralSecurityException {
		/*HttpTransport httpTransport = new NetHttpTransport();
		JacksonFactory jacksonFactory = new JacksonFactory();
*/
		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, String> map = new HashMap<>();
		Map<String, Object> map1 = objectmapper.readValue(login, new TypeReference<Map<String, Object>>() {
		});

		String idTokenString = (String) map1.get("idtoken");
		String gEmail = (String) map1.get("Email");
		String pictureUrl = (String) map1.get("ImageURL");
		String name = (String) map1.get("Name");
		/*GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, jacksonFactory)
				.setAudience(Collections
						.singletonList("430564811204-9t2gblq2m8hb51krbqh3dpvqbjl3i3hg.apps.googleusercontent.com"))
				.build();

		GoogleIdToken idToken = verifier.verify(idTokenString);
		if (idToken != null) {
			Payload payload = idToken.getPayload();

			String userId = payload.getSubject();

			String gEmail = ((com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload) payload).getEmail();
			boolean emailVerified = Boolean.valueOf(
					((com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload) payload).getEmailVerified());
			String name = (String) payload.get("name");
			String pictureUrl = (String) payload.get("picture");*/
			map.put("url", pictureUrl);
			
			if( helpObj.googleLogin(gEmail, name)){
				HttpSession htp = req.getSession(false);
				htp.setAttribute("useremail", gEmail);
				htp.setAttribute("pictureUrl", pictureUrl);
				map.put("ans", "Good");
				return objectmapper.writeValueAsString(map) ;
			}
			else{
			map.put("ans", "Invalid ID token.");
			return objectmapper.writeValueAsString(map) ;
		}
	}

	@RequestMapping(value="/DealerSignup", method=RequestMethod.POST)
	public String DealerSignp(@RequestBody String signup,HttpServletRequest req, HttpServletResponse res) throws IOException{
		
		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, Object> map1 = objectmapper.readValue(signup, new TypeReference<Map<String, Object>>() {
		});

		String email=(String)map1.get("email");
		String password =(String)map1.get("pwd");
		String dname=(String)map1.get("dealername");
		long number= Long.parseLong((String)map1.get("number"));
		
		 return helpObj.dealerSignUp(dname,email,number,password);
	}
	
	
	
	@RequestMapping(value = "/DealerLogin", method = RequestMethod.POST)
	@ResponseBody
	public String dealeracc(@RequestBody String dlogin, HttpServletRequest req, HttpServletResponse res)
			throws JsonParseException, IOException, JsonMappingException, JSONException, CacheException {

		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, String> map = new HashMap<>();

		Map<String, Object> map1 = objectmapper.readValue(dlogin, new TypeReference<Map<String, Object>>() {
		});

		String email = (String) map1.get("email");
		String password = (String) map1.get("password");
		String ans = helpObj.checkLogin("dealer", email, password);
		if (ans.equals("Good")) {
			HttpSession htp = req.getSession();
			htp.setAttribute("dealeremail", email);
		}
		map.put("ans", ans);
		return objectmapper.writeValueAsString(map);
	}

	
	
	
	
	@RequestMapping(value = "/AdminLogin", method = RequestMethod.POST)
	public ModelAndView adminacc(HttpServletRequest req, HttpServletResponse res) throws IOException {

		req.getSession().setAttribute("adminemail", "admin@full.co");

		String email = req.getParameter("email");
		String password = req.getParameter("pwd");
		if (email.equals("admin@full.co")) {
			if (password.equals("admin")) {
				return new ModelAndView("AdminProfile");
			} else {
				res.getWriter().println();
				return new ModelAndView("admin", "msg", "Password is wrong");
			}
		} else {
			return new ModelAndView("admin", "msg", "Email is wrong");
		}
	}

	
	
	
	
	@RequestMapping(value = "/proposal", method = RequestMethod.POST)
	public @ResponseBody String proposal(@RequestBody String proposed, HttpServletRequest req, HttpServletResponse res)
			throws IOException, JSONException {
		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, Object> map1 = objectmapper.readValue(proposed, new TypeReference<Map<String, Object>>() {
		});

		String ProductName = (String) map1.get("productName");
		long Price = Long.parseLong((String) (map1.get("price")));
		long Quantity = Long.parseLong((String) (map1.get("quantity")));
		long Discount = Long.parseLong((String) (map1.get("discount")));
		HttpSession htps = req.getSession(false);
		String dealermail = (String) htps.getAttribute("dealeremail");

		return helpObj.proposal_Helper(ProductName, Price, Quantity, Discount, dealermail);
	}

	
	
	
	
	@RequestMapping(value = "/DealerProfile", method = RequestMethod.POST)
	public @ResponseBody String DealerProfile(HttpServletRequest req, HttpServletResponse res) throws IOException {

		String dEmail = (String) req.getSession(false).getAttribute("dealeremail");
		return helpObj.getData_Profile("dealeremail", dEmail);
	}

	
	
	
	
	@RequestMapping(value = "/UserProfile", method = RequestMethod.POST)
	public @ResponseBody String userProfile(HttpServletRequest req, HttpServletResponse res) throws IOException {

		return helpObj.getData_Profile("type", "User");
	}

	
	
	
	
	@RequestMapping(value = "/AdminProfile", method = RequestMethod.GET)
	public @ResponseBody String AdminProfile(HttpServletRequest req, HttpServletResponse res) throws IOException {

		return helpObj.getData_Profile("type", "Dealer");
	}
	
	
	

	@RequestMapping("/datastoreAdd")
	public @ResponseBody String AddProposal(HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException {
		JSONObject jsonobj = new JSONObject(req.getParameter("jsonObj"));
		long index = 0;
		if (jsonobj.has("identity"))
			index = Long.parseLong(jsonobj.getString("identity"));

		return helpObj.admin_Helper(index, "add");
	}

	
	
	
	@RequestMapping("/deleteProposal")
	public @ResponseBody String DeleteProposal(HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException {

		JSONObject jsonobj = new JSONObject(req.getParameter("jsonObj"));
		long index = 0;
		if (jsonobj.has("identity"))
			index = Long.parseLong(jsonobj.getString("identity"));

		return helpObj.admin_Helper(index, "delete");
	}

	
	
	
	@RequestMapping(value="/cartAdd",method= RequestMethod.POST)
	public @ResponseBody String cartAdd(@RequestBody String cartDetails,HttpServletRequest req, HttpServletResponse res)
			throws IOException, JSONException {

		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, Object> map1 = objectmapper.readValue(cartDetails, new TypeReference<Map<String, Object>>() {
		});
		long index = (long) map1.get("identity");
		HttpSession htpSes = req.getSession();
		String email = (String) htpSes.getAttribute("useremail");

		return helpObj.cart_Helper("add", email, index);
	}

	
	
	
	@RequestMapping("/Cartremove")
	public void Cartremove(HttpServletRequest req, HttpServletResponse res)
			throws IOException, JSONException {

		JSONObject jsonobj = new JSONObject(req.getParameter("jsonObj"));
		long index = 0;
		if (jsonobj.has("identity")) {
			index = Long.parseLong(jsonobj.getString("identity"));
		}
		HttpSession htpSes = req.getSession();
		String email = (String) htpSes.getAttribute("useremail");
		helpObj.cart_Helper("remove", email, index);
	}

	
	
	
	
	@RequestMapping("/myCart")
	public @ResponseBody String myCart(HttpServletRequest req, HttpServletResponse res)
			throws IOException, JSONException {

		HttpSession htpSes = req.getSession();
		String email = (String) htpSes.getAttribute("useremail");
		return helpObj.cart_Helper("show", email, 0);
	}

	
	
	
	
	@RequestMapping("/delivery")
	public @ResponseBody String Delivery(HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException {
		JSONObject jsonobj = new JSONObject(req.getParameter("jsonObj"));

		if (jsonobj.has("identity")) {
			long index = Long.parseLong(jsonobj.getString("identity"));
			HttpSession session = req.getSession(false);
			String email = (String) session.getAttribute("useremail");
			Map <String,Long> hm = new HashMap<>();
			hm.put("id",index);
			session.setAttribute(email,hm);
		}
		return "";
	}

	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/deliveryPage")
	public @ResponseBody String DeliveryPage(HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException {
		HttpSession session = req.getSession(false);
		String email = (String) session.getAttribute("useremail");
		Map <String,Long> hm = (Map<String, Long>) session.getAttribute(email);
		long deliveryId = hm.get("id");
		return helpObj.delivery(deliveryId);
	}

	
	
	
	
	@RequestMapping(value = "/buyProduct", method = RequestMethod.POST)
	public @ResponseBody String buyProduct(@RequestBody String product ,HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException, ServletException {

		ObjectMapper objectmapper = new ObjectMapper();
		Map<String, Object> map1 = objectmapper.readValue(product, new TypeReference<Map<String, Object>>() {
		});
		String quan = (String)map1.get("quan");
		String id = (String)map1.get("identity");
		String phNumber= (String)map1.get("mobileNum");
		String addr = (String)map1.get("addr");
		HttpSession httpses =req.getSession(false);
		String email = (String) httpses.getAttribute("useremail");
		Map <String,String> hm = new HashMap<>();
		hm.put("id", id);
		hm.put("quantity", quan);
		hm.put("mobile", phNumber);
		hm.put("addr", addr);
		httpses.setAttribute(email, hm);
		return null;
	}

	

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/output", method = RequestMethod.POST)
	public ModelAndView Output(HttpServletRequest req, HttpServletResponse res)
			throws IOException, NumberFormatException, JSONException {
		HttpSession session = req.getSession(false);
		String email = (String) session.getAttribute("useremail");
		Map <String,String> hm =(Map<String, String>) session.getAttribute(email);
		
		long id = Long.parseLong(hm.get("id"));
		long phone = Long.parseLong(hm.get("mobile"));
		int quan = Integer.parseInt(hm.get("quantity"));
		String addr = hm.get("addr");
		helpObj.output(id, quan);
		DAO.deliveryPersist(email,id,quan,phone,addr,false);
		return new ModelAndView("Finish");
	}
	
	
	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @RequestMapping("/cronProposed") public void
	 * cronProposed(HttpServletRequest req, HttpServletResponse res) throws
	 * IOException, JSONException { memCache.put(2, memCache.get(1));
	 * memCache.remove(1); proposedList.clear(); userCount=0; deliveryCount=0;
	 * proposalCount=0; totalAmount=0; totalDiscount=0; }
	 */

	@RequestMapping("/todayProposal")
	public @ResponseBody String todayProposal(HttpServletRequest req, HttpServletResponse res)
			throws IOException, JSONException {

		return helpObj.todayProposal();
	}

	
	
	
	
	
	@RequestMapping("/taskReject")
	public void taskQueue(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException {

		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(TaskOptions.Builder.withUrl("/taskservlet"));

	}

	
	
	
	
	@RequestMapping("/taskservlet")
	public void taskservlet(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException {

		helpObj.taskHandler();
	}

	
	
	
	
	/*
	 * @RequestMapping("/statistics") public @ResponseBody String
	 * statistics(HttpServletRequest req, HttpServletResponse res) throws
	 * IOException, JSONException {
	 * 
	 * Map<String,Long> stat = new HashMap<>();
	 * 
	 * stat.put("obj0",(Long) userCount); stat.put("obj1", (Long)
	 * deliveryCount); stat.put("obj2", (Long) proposalCount); stat.put("obj3",
	 * (Long) totalAmount); stat.put("obj4",(Long) totalDiscount); ObjectMapper
	 * mapperObj = new ObjectMapper(); return
	 * mapperObj.writeValueAsString(stat);
	 * 
	 * }
	 */
}
