package com.example;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

@WebServlet("/deleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final SessionFactory sessionFactory = HibernateConfiguration.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        System.out.println("Received ID parameter: " + idParam);

        try {
            long customerId = Long.parseLong(idParam);
            System.out.println("Parsed Customer ID: " + customerId);

            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            Customer customer = session.get(Customer.class, customerId);
            System.out.println("Fetched Customer: " + customer);

            session.delete(customer);
            transaction.commit();

 request.getSession().setAttribute("successMessage", "Customer deleted successfully.");
            System.out.println("Customer deleted successfully.");

        } catch (Exception e) {
            
            return;
        }

        response.sendRedirect("customerListServlet");
    }
}
