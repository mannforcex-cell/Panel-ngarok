#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────────────────────────
#  TeleBot Panel — ngrok Tunnel Start
#  Jalankan dalam tab BARU Termux selepas python3 server.py
# ─────────────────────────────────────────────────────────────

CYAN='\033[0;96m'
GREEN='\033[0;92m'
YELLOW='\033[0;93m'
RED='\033[0;91m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

clear
echo ""
echo -e "${CYAN}${BOLD}  ╔══════════════════════════════════╗"
echo -e "  ║   TELEBOT PANEL · NGROK TUNNEL   ║"
echo -e "  ╚══════════════════════════════════╝${NC}"
echo ""

# Semak ngrok
if ! command -v ngrok &>/dev/null; then
  echo -e "  ${YELLOW}[!] ngrok tidak dijumpai. Memasang...${NC}"
  echo ""
  # Cuba pasang melalui pkg
  pkg install ngrok -y -q 2>/dev/null
  if ! command -v ngrok &>/dev/null; then
    echo -e "  ${RED}[✗] ngrok gagal dipasang melalui pkg${NC}"
    echo ""
    echo -e "  ${YELLOW}Pasang manual:${NC}"
    echo -e "  ${DIM}1. Pergi https://ngrok.com/download${NC}"
    echo -e "  ${DIM}2. Download untuk Linux ARM${NC}"
    echo -e "  ${DIM}3. Unzip dan salin ke ~/bin/ngrok${NC}"
    echo -e "  ${DIM}4. chmod +x ~/bin/ngrok${NC}"
    echo ""
    exit 1
  fi
fi

# Semak ngrok token
echo -ne "  ${DIM}[CHECK]${NC} ngrok auth token ... "
if ngrok config check &>/dev/null 2>&1; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${YELLOW}TIADA${NC}"
  echo ""
  echo -e "  ${YELLOW}Daftar token ngrok:${NC}"
  echo -e "  ${DIM}1. Pergi https://dashboard.ngrok.com/signup${NC}"
  echo -e "  ${DIM}2. Salin authtoken anda${NC}"
  echo -e "  ${DIM}3. Jalankan: ngrok config add-authtoken TOKEN_ANDA${NC}"
  echo ""
  echo -ne "  ngrok config add-authtoken 3DobSG41WxLRBQg2SiR5Gts052p_3Zj1EV9mHVRahzywPLD52: "
  read -r TOKEN
  if [ -n "$TOKEN" ]; then
    ngrok config add-authtoken "$TOKEN"
    echo -e "  ${GREEN}Token disimpan!${NC}"
  else
    echo -e "  ${RED}Token kosong — keluar${NC}"
    exit 1
  fi
fi

# Semak server berjalan
echo -ne "  ${DIM}[CHECK]${NC} Flask server port 5000 ... "
if curl -s http://localhost:5000 &>/dev/null; then
  echo -e "${GREEN}RUNNING${NC}"
else
  echo -e "${YELLOW}TIDAK AKTIF${NC}"
  echo -e "  ${YELLOW}Jalankan dahulu: python3 server.py${NC}"
  echo ""
  echo -ne "  Tunggu server start dan tekan Enter..."
  read -r
fi

echo ""
echo -e "  ${GREEN}${BOLD}Membuka terowong ngrok ke port 5000...${NC}"
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${CYAN}Copy URL https:// yang muncul di bawah${NC}"
echo -e "  ${CYAN}Paste dalam panel Netlify anda${NC}"
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

ngrok http 5000
