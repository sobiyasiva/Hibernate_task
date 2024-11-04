package com.example;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@WebServlet("/addCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {  
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        
        
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));

        
        Customer newCustomer = new Customer(name, email, phoneNumber, address, dateOfBirth);
        
        
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction(); 
            session.save(newCustomer); 
            transaction.commit(); 
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "Failed to add customer."); 
            request.getRequestDispatcher("error.jsp").forward(request, response); 
            return;
        }

        request.getSession().setAttribute("successMessage", "Customer added successfully.");
        response.sendRedirect("customerListServlet");
    }
    
public List<Customer> fetchAllCustomers() {
    List<Customer> customerList = null;
    try (Session session = sessionFactory.openSession()) {
        
        customerList = session.createQuery("FROM Customer", Customer.class).list();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return customerList;
}

}
