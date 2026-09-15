# GeoTurnos · Control y Registro de Turnos con Geolocalización

Web App **mobile-first**, sin build, lista para **Netlify / Vercel / GitHub Pages**.

## ▶️ Uso local
Opción 1 — doble clic en `index.html` (el GPS puede fallar en `file://` en móviles).

Opción 2 — servidor local (recomendado, requerido para GPS en escritorio):
```powershell
# Python
python -m http.server 5173
# luego abre http://localhost:5173
```

## 🚀 Deploy
- **Netlify:** arrastra la carpeta o conecta el repo. Publica `/` (este `index.html`).
- **Vercel:** `vercel deploy` o importa el repo. Sin build: framework = Other, output = `/`.
- **GitHub Pages:** Settings → Pages → Deploy from branch → `main` / root. El archivo `.nojekyll` ya está incluido.

> ⚠️ El GPS en móviles **exige HTTPS**. Los 3 proveedores anteriores lo dan gratis.

## ✨ Funciones
- Fichaje ENTRADA / SALIDA con `navigator.geolocation` (`enableHighAccuracy: true`).
- Guarda: nombre, evento, fecha/hora local + ISO, lat/lon, precisión y link a Google Maps.
- Persistencia en `localStorage` (`geoturnos_logs_v1`).
- Historial en tarjetas (móvil) + tabla (desktop), filtro por nombre y tipo.
- Exportar CSV compatible con Excel (con BOM), borrar individual o total con modal de confirmación.
- Stats: total, en turno ahora, fichajes de hoy. Autocompletado + chips de trabajadores recientes.
- Modo claro/oscuro, toasts, manejo amable de errores GPS (permiso denegado, sin señal, timeout, no soportado).

## 🔌 Nube con Supabase (ver fichajes de todos los celulares)
1. Crea un proyecto gratis en https://supabase.com → **New project**.
2. **SQL Editor → New query** → pega todo el archivo `supabase_schema.sql` → **Run**.
3. **Settings → API** → copia **Project URL** y **anon public key**.
4. En `index.html`, objeto `BACKEND`: pega `url` y `anonKey`, pon `enabled: true`.
5. Sube a GitHub / despliega. Cada fichaje se guarda en local **y** en la tabla `turnos`; al abrir la app se mezclan los de todos los dispositivos.

Sin backend la app funciona 100% en local.

## 📊 Vista de supervisor (`admin.html`)
Página de **solo lectura** para jefes/contadores: lee la nube, muestra stats, filtros por nombre/tipo/fecha, auto-actualiza cada 30 s y exporta CSV. No permite fichar ni borrar. Compártela por link, sin cuenta de Supabase.
