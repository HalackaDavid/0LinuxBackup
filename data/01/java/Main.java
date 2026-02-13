import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        
        Scanner scIn = new Scanner(System.in);

        while(true) {
            try {
                int Input = scIn.nextInt();
                if (Input < 18) {
                    System.out.print("<18");
                    break;
                } else if (Input < 65) {
                    System.out.print("<65");
                    break;
                } else {
                    System.out.print("dead");
                    break;
                }
            } catch(Exception e) {
                System.out.println("Hello World");
                scIn.next();
            }

        }
    }
}
