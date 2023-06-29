/*
    * Bayesian Search Game
    * Example of the game:
        0.005 0.7 0.002 0.6 0.001 0.3 0.007 0.6 0.007 1
        0 0.1 0.001 0.7 0.002 0.8 0.52 0.3 0.002 0.8
        0 0 0.001 0.8 0.002 0.9 0 0 0.004 0.6
        0.005 1 0.43 0.4 0 0 0 0 0.002 0.7
        0.001 0.7 0.003 0.8 0.002 0.7 0.002 0.3 0.001 0.9
    * The program will automatically recognize it as :
        Initial cell:
            0.0050 (0.70) | 0.0020 (0.60) | 0.0010 (0.30) | 0.0070 (0.60) | 0.0070 (1.00) |
            0.0000 (0.10) | 0.0010 (0.70) | 0.0020 (0.80) | 0.5200 (0.30) | 0.0020 (0.80) |
            0.0000 (0.00) | 0.0010 (0.80) | 0.0020 (0.90) | 0.0000 (0.00) | 0.0040 (0.60) |
            0.0050 (1.00) | 0.4300 (0.40) | 0.0000 (0.00) | 0.0000 (0.00) | 0.0020 (0.70) |
            0.0010 (0.70) | 0.0030 (0.80) | 0.0020 (0.70) | 0.0020 (0.30) | 0.0010 (0.90) |
     * And after you set the position of interest i,j (i-th row, j-th column),
     * the program will begin searching for the object with bayesian search.
     *
     * The final cell of this example after 5 rounds of search looks like:
        The final cell looks like
            0.0130 (0.70) | 0.0052 (0.60) | 0.0026 (0.30) | 0.0183 (0.60) | 0.0183 (1.00) |
            0.0000 (0.10) | 0.0026 (0.70) | 0.0052 (0.80) | 0.4655 (0.30) | 0.0052 (0.80) |
            0.0000 (0.00) | 0.0026 (0.80) | 0.0052 (0.90) | 0.0000 (0.00) | 0.0104 (0.60) |
            0.0130 (1.00) | 0.4040 (0.40) | 0.0000 (0.00) | 0.0000 (0.00) | 0.0052 (0.70) |
            0.0026 (0.70) | 0.0078 (0.80) | 0.0052 (0.70) | 0.0052 (0.30) | 0.0026 (0.90) |
      * It correctly found the object in a relatively short time.
      * It also might take less than 5 rounds to find the object.
      * Because there is a chance you find it at first glance.
 */

import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class Search {

    private static Boolean printp = false;
    private static Boolean randomPos = false;
    private static final Scanner in = new Scanner(System.in);
    private static final Random random = new Random();
    public static void main(String[] args) {
        displayWelcome();
        System.out.println("Enter the size of the cells: ");
        int size = in.nextInt();
        int[] finalLoc;
        if(randomPos) {
            finalLoc = generatePosition(size);
        }else{
            System.out.println("Enter the position of interest: ");
            finalLoc = new int[2];
            finalLoc[0] = in.nextInt();
            finalLoc[1] = in.nextInt();
        }
        Cells cells = new Cells(size);

        System.out.println("Initial cell:");
        displayCell(cells);

        int counter = 0;
        while(!checkCell(cells, finalLoc)){
            updateParam(cells);
            counter++;
        }

        System.out.println("The object of interest is found after " + counter+ " rounds!");
        System.out.println("It is in " + cells.c[0].x + " " + cells.c[0].y);
        System.out.println("The final cell looks like");
        displayCell(cells);
        System.out.println("Congratulations!");
    }

    static void displayWelcome(){
        System.out.println("Welcome to the Bayesian Search Game!");
        System.out.println("The object of interest is hidden in a grid of cells.");
        System.out.println("Cell i, j means the cell in the i-th row, j-th column");
        System.out.println("By Lumi, 2023");
        System.out.println();

        //Check if the user want to print the probability of finding the object p
        System.out.println("Do you want to print probability of finding p (y/n): ");
        if(in.next().equals("y")){
            printp = true;
        }else{
            printp = false;
        }

        System.out.println("Do you want to set the position of interest (y/n): ");
        if(in.next().equals("y")){
            randomPos = false;
        }else{
            randomPos = true;
        }
    }

    static boolean checkCell(Cells cells, int[] finalLoc){
        Arrays.sort(cells.c, (c1, c2) -> Double.compare(c2.p * c2.pi, c1.p * c1.pi));
        double ran = random.nextDouble();
        cell tmp = cells.c[0];
        System.out.println("Checking cell " + tmp.x + " " + tmp.y);
        System.out.println();
        if(ran < tmp.p && tmp.x == finalLoc[0] && tmp.y == finalLoc[1]){
            return true;
        }else{
            return false;
        }
    }

    static void updateParam(Cells cells){
        for(int i = 1; i < cells.c.length; i++){
            cells.c[i].pi = cells.c[i].pi * (1 / (1 - cells.c[0].p * cells.c[0].pi));
        }
        cells.c[0].pi = cells.c[0].pi * ((1 - cells.c[0].p) / (1 - cells.c[0].p * cells.c[0].pi));

        displayCell(cells);
    }

    static void displayCell(Cells cells){
        cell tmp = cells.head;
        int counter = 0;
        while(tmp != null){
            if(!printp) {
                System.out.printf("%.5f ", tmp.pi);
            }else{
                System.out.printf("%.4f (%.2f) | ", tmp.pi, tmp.p);
            }
            tmp = tmp.next;
            counter++;
            if(counter == cells.n){
                System.out.println();
                counter = 0;
            }
        }
        System.out.println();
    }

    static int[] generatePosition(int size){
        int a = random.nextInt(size);
        int b = random.nextInt(size);
        System.out.println("The object of interest is in " + a + " " + b);
        return new int[]{a, b};
    }

    static class Cells{
        int n;
        cell[] c;
        cell head;
        Cells(int n){
            this.n = n;
            this.c = new cell[n * n];
            System.out.println("Use preset values? (y/n)");
            String s = in.next();
            if(s.equals("y")){
                double a = (double) 1 / (n * n);
                for(int i = 0; i < c.length; i++){
                    c[i] = new cell(a, 0.5, i/n, i%n);
                }
            }else{
                System.out.println("Enter your values of pi and p for each cell: ");
                for(int i = 0; i < c.length; i++){
                    int A = i / n;
                    int B = i % n;
//                    System.out.println("Set value for cell " + A + " " + B + "(decimal): pi p");
                    double a = in.nextDouble();
                    double b = in.nextDouble();
                    c[i] = new cell(a, b, A, B);
                }
            }
            this.head = c[0];
            for(int i = 0; i < c.length - 1; i++){
                c[i].next = c[i + 1];
            }
        }
    }

    static class cell{
        double pi, p;
        int x, y;
        cell next;

        cell(double pi, double p, int x, int y) {
            this.pi = pi;
            this.p = p;
            this.x = x;
            this.y = y;
        }
    }

}
