import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        
        Scanner scIn = new Scanner(System.in);

        while(true) {
            try {
                int Input = scIn.nextInt();
            } catch(Exception e) {
                System.out.println("Hello World");
                continue;
            }
        }
    }
}
