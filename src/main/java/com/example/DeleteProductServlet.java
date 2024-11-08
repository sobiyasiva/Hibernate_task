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

@WebServlet("/deleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final SessionFactory sessionFactory = HibernateConfiguration.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        try {
            long productId = Long.parseLong(idParam);
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            Product product = session.get(Product.class, productId);


            session.delete(product);
            transaction.commit();

 request.getSession().setAttribute("successMessage", "Product deleted successfully.");


        } catch (Exception e) {
            System.out.println(e);
            
        }
        request.getSession().setAttribute("successMessage", "Product deleted successfully.");
        response.sendRedirect("product");
    }
}
