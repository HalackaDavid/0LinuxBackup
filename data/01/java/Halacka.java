import java.util.Scanner;

public class Halacka {
    public static void main(String[] args) {
        Scanner userInput = new Scanner(System.in);
        String input;
        int rounds = 0, 
            addNumber = 0,
            total = 0;

        do {
            System.out.print("číslo 0-100 nebo konec >> ");
            input = userInput.nextLine();
            
            try {
                addNumber = Integer.parseInt(input);

                if (addNumber < 0) {
                    continue;
                } else if (addNumber > 100) {
                    System.out.print("Maximální počet bodů na jedno kolo je 100!\n");
                    continue;
                }
                total = addNumber + total;
                rounds++;
            } catch (NumberFormatException e) {
                if (input.equals("konec")) {
                    break;
                } else {
                    System.out.print("Neplatný vstup!\n");
                }
            }
        } while(true);
        
        if (total > -1 && rounds > 0) {
            int avg = total / rounds;
            String msg = "";

            if (avg > 75) {
                msg = "Výborný výkon";
            } else if (avg > 39) {
                msg = "Průměrný výkon";
            } else {
                msg = "Slabý výkon";
            }
            
            System.out.print("===============================\ntotal : " + total + "\nrounds: " + rounds + "\navg   : " + avg + "\nmsg   : " + msg + "\n===============================\n");
        }

        userInput.close();
    }
}
