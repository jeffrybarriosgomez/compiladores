
package codigo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author JEFFRY
 */
public class Main {
    public static void main(String[] args) throws Exception{
       String rutaLexer = "src/jflex/Lexer.flex";
       String rutaLexerCup = "src/jflex/LexerCup.flex";
       String[] rutaSintax = {"-parser", "Sintax", "src/jflex/Sintax.cup"};
       generar(rutaLexer, rutaLexerCup, rutaSintax);
       
       FrmMain frm = new FrmMain();
       frm.setVisible(true);
       

    }
    public static void generar(String rutaLexer, String rutaLexerCup, String[] rutaSintax) throws IOException, Exception{
         File archivo;
        archivo = new File(rutaLexer);
        JFlex.Main.generate(archivo);
        archivo = new File(rutaLexerCup);
        JFlex.Main.generate(archivo);
        java_cup.Main.main(rutaSintax);
        
        Path rutaSym = Paths.get("src/codigo/sym.java");
        if (Files.exists(rutaSym)) {
            Files.delete(rutaSym);
        }
        Files.move(
            Paths.get("./sym.java"), 
            Paths.get("src/codigo/sym.java")
        );
        
        Path rutaSin = Paths.get("src/codigo/Sintax.java");
        if (Files.exists(rutaSin)) {
            Files.delete(rutaSin);
        }
        
        Files.move(
        Paths.get("./Sintax.java"), 
        Paths.get("src/codigo/Sintax.java")
        );
        
        Path pathLexer = Paths.get("src/codigo/Lexer.java");
        if (Files.exists(pathLexer)) {
            Files.delete(pathLexer);
        }
        
        Files.move(
        Paths.get("src/jflex/Lexer.java"), 
        Paths.get("src/codigo/Lexer.java")
        );
        Path pathLexerCup = Paths.get("src/codigo/LexerCup.java");
        if (Files.exists(pathLexerCup)) {
            Files.delete(pathLexerCup);
        }
        
        Files.move(
        Paths.get("src/jflex/LexerCup.java"), 
        Paths.get("src/codigo/LexerCup.java")
        );
        
    }
}
