import java.util.Scanner;

public class Halacka {
    public static void main(String[] args) {
        // 1 - vypis inventare
        // 2 - vstup do mistnosti
        // 3 - ukonceni programu
        Scanner Input = new Scanner(System.in);
        String[] inventory = {"1", "2", "1", "1", "30"};
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
                    System.out.printf("2\n\n");
                    break;
                case 3:
                    return;
                default:
                    System.out.printf("neni spravna moznost\n\n");
            }
        }
    }
}
