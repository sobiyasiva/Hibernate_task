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
import org.hibernate.cfg.Configuration;

@WebServlet("/customerListServlet")
public class CustomerListServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customerList = fetchAllCustomers();
        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }

    public List<Customer> fetchAllCustomers() {
        List<Customer> customerList = null;
        try (Session session = sessionFactory.openSession()) {
            customerList = session.createQuery("FROM Customer", Customer.class).list();
        } catch (Exception e) {
           System.out.println(e);
        }
        return customerList;
    }

  
}
