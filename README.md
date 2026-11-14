# 💬 ADDA — Friends-only Glass Chat (Full Build v2)

Free, installable (PWA) chat app for a small friend group.
**Everything is inside `server.js`** (frontend embedded) — so deployment never breaks because of a missing folder.

---

## ✨ Features

| Feature | Details |
|---|---|
| ⏳ 30-min auto-delete | Every message (text/photo/video) vanishes after 30 min. Countdown shows in the last 60 sec. |
| ⬇ Download | Save photo/video before it disappears. |
| ↩ Unsend | Remove your message for everyone (admin can unsend any). |
| ✏️ Edit | Edit your own text messages. Others only see an “edited” tag. **Full edit history is visible ONLY to admin.** |
| 📌 Pin | Pin up to 5 messages per chat (group or private). Pinned bar at top; click to jump. |
| ↩ Reply | Reply to a specific message with a quote bubble. |
| 🔥 Reactions | React with 👍 ❤️  😮 😢 🔥 (tap again to remove). |
| 🖼 Profile photo | Upload a profile picture (auto-resized). Fallback emoji + color. |
| 🎨 Themes | Aurora, **Black**, **White**, Ocean, Sunset, Forest. Saved on your device. |
| 👥 Group + Private | One common group + separate private inbox per friend. |
| 🛡 Admin | Separate panel: read ALL messages (group + private), see edit history, block/unblock users. |
| 😊 Emoji picker | Full emoji panel. |
| 📲 PWA | Install on phone home screen (Android Chrome / iPhone Safari). |
| 🗄 Supabase (optional) | Permanent accounts / block list / login sessions across restarts. |

> 🔐 Privacy note: admin can read all messages (including private). There is **no end-to-end encryption**. Tell your friends.

---

## 📁 Files in this ZIP

```
server.js          ← the whole app (backend + embedded frontend)
package.json       ← dependencies + start script
package-lock.json
render.yaml        ← Render.com blueprint (optional)
supabase.sql       ← run once in Supabase SQL Editor (optional)
.gitignore
public/            ← frontend source (for editing; NOT required to deploy)
README.md          ← this guide
```

**To deploy you only need:** `server.js` + `package.json` (+ `package-lock.json`).
`public/` is included only if you want to edit the UI source later.

---

## 🚀 Deploy FREE on Render (permanent link)

### 1) Put code on GitHub
1. https://github.com → **New repository** → name `adda-chat` → Public → Create.
2. **Add file → Upload files** → drag these from the ZIP:
   `server.js`, `package.json`, `package-lock.json`, `render.yaml`, `.gitignore`, `supabase.sql`, `README.md`
   (You can also upload `public/` — optional.)
3. **Commit changes**.

> Replacing an old repo? Upload the new `server.js` + `package.json` + `package-lock.json` (overwrite). That’s enough.

### 2) Create the web service on Render
1. https://render.com → login with GitHub → **New + → Web Service**.
2. Connect the `adda-chat` repo.
3. Settings:
   - **Runtime:** Node
   - **Build Command:** `npm install`
   - **Start Command:** `node server.js`
   - **Instance Type:** **Free**
4. **Environment Variables** (Advanced):
   | Key | Value |
   |---|---|
   | `ADMIN_KEY` | a secret key of your choice (e.g. `shadik-2026`) |
5. **Create Web Service** → wait 2–4 min → you get `https://adda-chat-xxxx.onrender.com`.

### 3) First login = Admin
- Open the link → **Register**. The **first account becomes admin** 👑.
- Or use the `ADMIN_KEY` in the Register form’s “Admin key” box.
- Friends register after you → they land in the Group Adda.

### 4) Keep it awake (free)
Render free sleeps after ~15 min idle. Use **UptimeRobot** (free):
1. https://uptimerobot.com → **Add New Monitor** → HTTP(s).
2. URL: `https://YOUR-APP.onrender.com/healthz`
3. Interval: **5 minutes** → Create.
This pings the app so it stays awake and emails you if it goes down.

> ⚠️ Render free = 750 instance-hours/month per workspace. One app kept awake 24/7 uses ~720–744 h, so it fits. Don’t keep many free apps awake at once.

---

## 🗄 Supabase (optional but recommended for permanent accounts)

Without Supabase, accounts live on Render’s temporary disk and can reset on redeploy.
With Supabase, accounts / block list / login sessions survive restarts.

1. https://supabase.com → **New project** → name `adda-chat`, region **Singapore**, set a DB password → Create.
2. **SQL Editor → New query** → paste the contents of `supabase.sql` → **Run**.
3. **Project Settings → API** → copy:
   - **Project URL** (`https://xxxx.supabase.co`)
   - **service_role** key (⚠️ secret — NOT the `anon` key)
4. Render → your service → **Environment** → add:
   | Key | Value |
   |---|---|
   | `SUPABASE_URL` | Project URL |
   | `SUPABASE_SERVICE_ROLE_KEY` | service_role key |
5. Save → auto-redeploy. Logs show `Storage: Supabase connected ✓`.
6. `/healthz` shows `"storage":"supabase"`.

> 📌 When you first connect Supabase, accounts start **fresh** (old local accounts are not migrated). Register again once (first = admin). After that, accounts are permanent.
> Messages are **never** stored in Supabase — they still auto-delete after 30 min.
> ⚠️ Supabase free projects pause after ~1 week of inactivity. Regular use (or the UptimeRobot ping hitting the app, which reads Supabase on boot) keeps it active; if paused, click **Restore** in Supabase dashboard.

---

## 📱 Install on phone

- **Android (Chrome):** open the Render link → menu ⋮ → **Install app** / **Add to Home screen**.
- **iPhone (Safari):** open link → Share □↑ → **Add to Home Screen**.
- The app icon appears on the home screen and opens full-screen.

---

## 🖥 Run on laptop (optional)

```bash
npm install
npm start
```
Open http://localhost:3000. Friends on the same WiFi: `http://<your-IPv4>:3000` (find IP via `ipconfig`).

---

## 🛡 Admin panel

- Sidebar → **Admin Panel**.
- **All Messages:** every group + private message, with ✏️ edit history (admin-only).
- **Users & Block:** block / unblock any non-admin user. Blocked users are disconnected and cannot log in.

---

## 🎨 Profile & Theme

- Sidebar → **Profile & Theme** (or tap your name).
- Upload photo, change name / emoji / color.
- Pick a theme: Aurora / Black / White / Ocean / Sunset / Forest.

---

## 🔧 Troubleshooting

| Problem | Fix |
|---|---|
| `Cannot GET /` | You deployed an old `server.js`. Upload the new `server.js` from this ZIP and redeploy. |
| Build fails on Render | Make sure `package.json` + `server.js` are uploaded; Build = `npm install`, Start = `node server.js`. |
| Link slow first time | Free plan wake-up (30–60 s). Add UptimeRobot ping. |
| Accounts reset after redeploy | Add Supabase env vars (above). |
| `Storage: local JSON` in logs | Supabase env vars not set / wrong. Check `SUPABASE_URL` + `SUPABASE_SERVICE_ROLE_KEY`. |
| Install option missing | Use the HTTPS Render link (not localhost) in Chrome/Safari. |
| Friend can’t join | Share the same Render link; they must Register. |

---

## 🔒 Security honesty

- Passwords are hashed (scrypt). Sessions use random tokens.
- **Admin can read all messages** (by design). No E2EE.
- Keep `ADMIN_KEY` and `SUPABASE_SERVICE_ROLE_KEY` secret. Never put them in GitHub.
- This is a friends-only hobby app, not a high-security product.

---

Built with Express + Socket.IO + Multer. Frontend: vanilla JS + glassmorphism CSS. PWA manifest + service worker included.
