import java.util.Scanner;
import java.util.Random;

public class Halacka {
    public static void main(String[] args) {
        Scanner Input = new Scanner(System.in);
        Random Rnd = new Random();
        
        String[] inventory = {"sword", "torch", "1", "1", "30"};
        int option = 0;

        while (true) {
            System.out.printf("Select options: \n[1] vypis inventare\n[2] vstup do mistnosti\n[3] ukonceni programu\n>>> ");
            try {
                option = Integer.parseInt(Input.nextLine());
            } catch(NumberFormatException e) {
                System.out.printf("pouze cisla\n\n");
            }

            switch (option) {
                case 1:
                    for (String s: inventory) {
                        System.out.printf("%s\n", s);
                    }
                    System.out.printf("\n");
                    break;
                case 2:
                    //System.out.printf("%d\n2\n\n", r);
                    switch (Rnd.nextInt(3)) {
                        case 0:
                            System.out.printf("Sword room\n");
                            for(String s: inventory) {
                                if (s.equals("sword")) {
                                    System.out.printf("sword equiped monster slayed\n");
                                }
                            }
                            break;
                        case 1:
                            System.out.printf("Torch room\n");
                            for(String s: inventory) {
                                if (s.equals("torch")) {
                                    System.out.printf("torch equiped and i see\n");
                                } 
                            }
                            break;
                        case 2:
                            System.out.printf("empty room\n");
                            break;
                    }
                    break;
                case 3:
                    return;
                default:
                    System.out.printf("neni spravna moznost\n\n");
            }
            System.out.printf("\n");
        }
    }
}
