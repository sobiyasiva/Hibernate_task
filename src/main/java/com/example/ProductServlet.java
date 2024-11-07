package com.example;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

public class ProductServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    @Override
    public void init() throws ServletException {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
            System.out.println("SessionFactory initialized successfully.");
            insertSampleProductData();
        } catch (Exception e) {
            System.out.println("SessionFactory initialization failed.");
            e.printStackTrace();
            throw new ServletException("Could not initialize SessionFactory", e);
        }
    }

    private void insertSampleProductData() {
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            session.save(new Product("Product A", 1249.99));
            session.save(new Product("Product B", 26549.99));
            session.save(new Product("Product C", 34349.99));
            
            transaction.commit();
            System.out.println("Sample product data inserted.");
        } catch (Exception e) {
            System.out.println("Error inserting sample product data.");
            e.printStackTrace();
        }
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products;
        try (Session session = sessionFactory.openSession()) {
            Query<Product> query = session.createQuery("FROM Product", Product.class);
            products = query.getResultList();
        } catch (Exception e) {
            System.out.println("Error retrieving product list.");
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching the product list.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        request.setAttribute("productList", products);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }


    public static void main(String[] args) {
        ProductServlet productServlet = new ProductServlet();
        
        try {
            productServlet.init();
            System.out.println("Servlet initialized and sample data inserted.");
        } catch (ServletException e) {
            System.err.println("Servlet initialization failed: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("An unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            productServlet.destroy();
        }
    }
}
