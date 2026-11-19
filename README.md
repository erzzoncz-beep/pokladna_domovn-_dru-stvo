# Pokladna domovního družstva

Statická instalační webová aplikace (PWA) s veřejným přehledem a editací vyhrazenou admin účtu.

## Nasazení přes GitHub Pages

Workflow `.github/workflows/pages.yml` publikuje obsah repozitáře při každém commitu do `main`.

1. V GitHub repozitáři otevři **Settings → Pages**.
2. U **Build and deployment** vyber **GitHub Actions**.
3. Po doběhnutí workflow otevři zveřejněnou adresu `https://erzzoncz-beep.github.io/pokladna_domovn-_dru-stvo/`.
4. Aplikaci lze na PC nainstalovat z nabídky Chrome/Edge. Na Androidu přes Chrome „Instalovat aplikaci“; na iOS přes Safari → Sdílet → Přidat na plochu.

## Supabase (před zapnutím produkčního přehledu)

1. Vytvoř Supabase projekt.
2. V SQL Editoru spusť `supabase-schema.sql`.
3. V `supabase-config.js` doplň Project URL a veřejný publishable key.
4. V Supabase Auth vytvoř jediný admin účet a následně zakaž veřejnou registraci.
5. Po nasazení doplň produkční webovou adresu do Auth URL Configuration.

**Bez nastaveného Supabase zobrazuje aplikace jen lokální prázdnou pokladnu.** Nikdy nedávej do repozitáře databázové heslo ani Supabase secret/service_role key. Veřejný přehled zahrnuje i fotografie dokladů, které mohou obsahovat osobní údaje.

## Přístupy

- Anonymní návštěvníci mají v databázi pouze čtecí právo.
- Admin se přihlašuje e-mailem a heslem přes „Správa · pouze admin“.
- Úpravy ověřuje RLS v Postgresu, ne pouze skrytí tlačítek v prohlížeči.
- Admin může změnit e-mail a heslo v nastavení aplikace.

## Exporty

Tisk/PDF, PNG, CSV, XLSX, DOCX a JSON záloha. Knihovny pro XLSX/DOCX se načítají z CDN.

