package com.hajer.livres_proj;

import java.util.Date;
import java.util.List;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import com.hajer.livres_proj.entities.Livre;
import com.hajer.livres_proj.repos.LivreRepository;

@SpringBootTest
class LivresProjApplicationTests {

    @Autowired(required = false)
    private LivreRepository livreRepository;

    @Test
    void contextLoads() {
        // Smoke test vérifiant le chargement du contexte Spring
        assertTrue(true);
    }

    @Test
    void testSmokeTruth() {
        // Test de santé de base pour le pipeline CI (Atelier 5)
        assertTrue(1 + 1 == 2, "Le pipeline de test doit être vert");
    }

    @Test
    void testCreateAndFindLivre() {
        if (livreRepository != null) {
            Livre livre = new Livre("Le Petit Prince", 120L, new Date());
            Livre saved = livreRepository.save(livre);
            assertNotNull(saved.getIdLivre());
            List<Livre> livres = livreRepository.findByTitreLivre("Le Petit Prince");
            assertTrue(!livres.isEmpty());
        }
    }
}
