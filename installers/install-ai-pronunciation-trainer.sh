#!/usr/bin/env bash
# ============================================================================
# AI Pronunciation Trainer — One-Click Installer
# Source: https://github.com/Thiagohgl/ai-pronunciation-trainer
# ============================================================================

set -euo pipefail

# ─── Colors ──────────────────────────────────────────────────────────────────
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

REPO_URL="https://github.com/Thiagohgl/ai-pronunciation-trainer.git"
INSTALL_DIR="${INSTALL_DIR:-$HOME/ai-pronunciation-trainer}"

echo -e "${CYAN}${BOLD}🎤  AI Pronunciation Trainer — Installer${NC}\n"

# ─── Prerequisites ───────────────────────────────────────────────────────────
echo -e "${CYAN}Checking prerequisites...${NC}"

if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
    echo -e "${RED}✗ Python 3 not found. Install it from https://www.python.org/downloads/${NC}"
    exit 1
fi

PYTHON=$(command -v python3 2>/dev/null || command -v python)
PY_VER=$("$PYTHON" -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
echo -e "  Python $PY_VER ... ${GREEN}OK${NC}"

if ! command -v git &>/dev/null; then
    echo -e "${RED}✗ Git not found. Install it from https://git-scm.com/${NC}"
    exit 1
fi
echo -e "  git ... ${GREEN}OK${NC}"

if ! command -v ffmpeg &>/dev/null; then
    echo -e "${YELLOW}⚠  FFmpeg not found. Attempting to install...${NC}"
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y ffmpeg
    elif command -v brew &>/dev/null; then
        brew install ffmpeg
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y ffmpeg
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm ffmpeg
    else
        echo -e "${RED}✗ Could not install FFmpeg automatically.${NC}"
        echo -e "  Please install it manually: https://ffmpeg.org/download.html"
        exit 1
    fi
fi
echo -e "  ffmpeg ... ${GREEN}OK${NC}"

# ─── Clone Repository ────────────────────────────────────────────────────────
echo -e "\n${CYAN}Cloning repository to ${INSTALL_DIR}...${NC}"
if [ -d "$INSTALL_DIR/.git" ]; then
    echo -e "${YELLOW}  Directory already exists — pulling latest changes...${NC}"
    git -C "$INSTALL_DIR" pull --ff-only
else
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ─── Virtual Environment ─────────────────────────────────────────────────────
echo -e "\n${CYAN}Creating virtual environment...${NC}"
"$PYTHON" -m venv "$INSTALL_DIR/.venv"
VENV_PY="$INSTALL_DIR/.venv/bin/python"
VENV_PIP="$INSTALL_DIR/.venv/bin/pip"

# ─── Install Dependencies ────────────────────────────────────────────────────
echo -e "\n${CYAN}Installing Python dependencies (this may take a few minutes)...${NC}"
"$VENV_PIP" install --upgrade pip --quiet
"$VENV_PIP" install -r "$INSTALL_DIR/requirements.txt" \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    --quiet

# ─── Create Launcher ─────────────────────────────────────────────────────────
LAUNCHER="$INSTALL_DIR/start.sh"
cat > "$LAUNCHER" << EOF
#!/usr/bin/env bash
set -e
cd "$INSTALL_DIR"
echo "Starting AI Pronunciation Trainer at http://127.0.0.1:3000"
"$VENV_PY" webApp.py
EOF
chmod +x "$LAUNCHER"

# ─── Done ────────────────────────────────────────────────────────────────────
echo -e "\n${GREEN}${BOLD}✅ Installation Complete!${NC}"
echo -e "  Install location : ${BOLD}${INSTALL_DIR}${NC}"
echo -e "  To start         : ${BOLD}bash ${LAUNCHER}${NC}"
echo -e "  Then open        : ${BOLD}http://127.0.0.1:3000${NC} in Chrome\n"
