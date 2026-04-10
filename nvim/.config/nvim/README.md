# hiengyen.nvim

[🇻🇳 Tiếng Việt](#phiên-bản-tiếng-việt) | [🇬🇧 English](#english-version)

---

## Phiên Bản Tiếng Việt

Chào mừng bạn đến với **hiengyen.nvim** - một bộ cấu hình Neovim được tinh chỉnh và nâng cấp cực kỳ mạnh mẽ dựa trên nền tảng Kickstart.nvim. Cấu hình này được tùy biến để mang lại trải nghiệm code mượt mà, thông minh và đầy đủ tính năng nhất tựa như một IDE hiện đại.

### 🚀 Các Ngôn Ngữ Được Hỗ Trợ Toàn Diện

Bộ cấu hình nhúng sẵn hệ sinh thái phân tích mã nguồn (LSP + Formatter + Treesitter) hoạt động tự động dưới nền:
*   **Python**: Mạnh mẽ với `pyright` (Phân tích tĩnh/Gợi ý) và `ruff` (Linter & Formatter siêu tốc).
*   **C / C++**: `clangd` & `clang-format`.
*   **Golang**: `gopls`, `goimports` & `gofmt`.
*   **Rust**: `rust_analyzer` & `rustfmt`.
*   **Bash/Shell**: `bashls` & `shfmt`.
*   **Nix**: `nil_ls` & `nixfmt`.
*   **Lua**: `lua_ls` & `stylua`.

### 📖 Sổ Tay Hướng Dẫn Sử Dụng (Cheat Sheet)

*(Lưu ý: Phím **`<Leader>`** mặc định được cấu hình là phím **`Space` (Dấu Cách)**)*

#### 1. Phím tắt Nền tảng & Di chuyển
*   **`<Ctrl> + s`**: Lưu file siêu nhanh (Hoạt động ở mọi chế độ).
*   **`<Ctrl> + h/j/k/l`**: Nhảy qua lại giữa các cửa sổ chia đôi (Split Window).
*   **`<Esc><Esc>`**: Thoát chế độ Terminal.

#### 2. Quản lý Không gian làm việc (Window Splits)
*   **`<Leader> + wv`**: Cắt màn hình chia làm hai theo chiều dọc (Window Vertical).
*   **`<Leader> + ws`**: Cắt màn hình chia làm hai theo chiều ngang (Window Split).
*   **`<Leader> + wq`** hoặc **`<Leader> + qq`**: Đóng cửa sổ hiện tại cực nhanh.

#### 3. Tìm kiếm "Thần tốc" (Telescope)
*   **`<Leader> + sf`** *(Search Files)*: Tìm file trong dự án.
*   **`<Leader> + sg`** *(Search by Grep)*: Tìm kiếm bất kỳ văn bản nào xuyên suốt toàn bộ dự án.
*   **`<Leader> + sw`** *(Search Word)*: Tìm từ khoá nơi con trỏ chuột đang chỉ.
*   **`<Leader> + <Leader>`**: Chọn nhanh một file đang mở trước đó.
*   **`<Leader> + /`**: Tìm kiếm nội dung trong file hiện hành.

#### 4. Quản lý Thư mục (Neo-tree)
*   **`\` (Dấu gạch chéo ngược)**: Mở/Đóng nhanh thanh cây thư mục bên tay trái.
    *   *Trong cây thư mục*: Bấm `a` để tạo mục mới, `d` xoá, `r` đổi tên.

#### 5. Sức mạnh IDE (LSP & Autocomplete)
*   **Gợi ý code**: Dùng mũi tên hoặc `<Ctrl>+n / <Ctrl>+p` để lên xuống menu. **Bấm `Tab`** để điền hoàn thiện chữ.
*   **`grd`** *(Goto Definition)*: Nhảy đến vị trí khai báo gốc của biến/hàm.
*   **`grr`** *(Goto References)*: Liệt kê nơi biến/hàm được gọi.
*   **`grn`** *(Rename)*: Đổi tên biến đồng loạt trên toàn bộ tầm vực.
*   **`gra`** *(Code Action)*: Tự động sửa lỗi (VD: tự động import thư viện).

#### 6. Tự động Định dạng (Conform)
*   Mặc định **khi bấm Lưu file (`<Ctrl> + s`)**, code sẽ tự động căn lề hoàn hảo dựa trên tiêu chuẩn cốt lõi của từng ngôn ngữ.
*   **`<Leader> + f`**: Ép định dạng thủ công bất kỳ lúc nào.

#### 7. Dấu vết Git (Gitsigns)
*   **`]c` / `[c`**: Nhảy nhanh đến dòng code bị thay đổi tiếp/trước.
*   **`<Leader> + hp`** *(Hunk Preview)*: Xem code quá khứ ở dòng hiện tại trước khi bị sửa đổi trông thế nào.
*   **`<Leader> + tb`** *(Toggle Blame)*: Hiển thị mờ mờ ở cuối dòng tên kèm thời điểm thao tác git của người viết (blame).

#### 8. Bao bọc chữ nhanh (Mini.surround)
*   **Cách Bọc Chữ (saiw + <dấu>)**: Trỏ vào chữ. Gõ nhanh **`s` -> `a` -> `i` -> `w` -> `"`**. 
*   **Cách Gỡ Bỏ (sd + <dấu>)**: Trỏ vào chữ bị bọc. Gõ nhanh **`s` -> `d` -> `"`**. Lập tức cặp ngoặc sẽ biến mất.

---

## English Version

Welcome to **hiengyen.nvim** - an extremely powerful, customized Neovim configuration built on top of the Kickstart.nvim framework. This setup transforms Neovim into a modern IDE, specially tuned to offer a seamless, intelligent, and rich coding experience.

### 🚀 Fully Supported Languages

This configuration comes with an out-of-the-box system (LSP + Formatter + Treesitter) seamlessly running in the background for:
*   **Python**: Supercharged with `pyright` (Static Type checking) and `ruff` (Lightning-fast Linter & Formatter).
*   **C / C++**: `clangd` & `clang-format`.
*   **Golang**: `gopls`, `goimports` & `gofmt`.
*   **Rust**: `rust_analyzer` & `rustfmt`.
*   **Bash/Shell**: `bashls` & `shfmt`.
*   **Nix**: `nil_ls` & `nixfmt`.
*   **Lua**: `lua_ls` & `stylua`.

### 📖 Usage Cheat Sheet

*(Note: The **`<Leader>`** key is customized to the **`Space`** bar)*

#### 1. Fundamental Keybinds & Navigation
*   **`<Ctrl> + s`**: Instant file saving (works in Normal, Insert, and Visual modes).
*   **`<Ctrl> + h/j/k/l`**: Navigate efficiently between split windows.
*   **`<Esc><Esc>`**: Exit built-in Terminal mode easily.

#### 2. Workspace & Window Management
*   **`<Leader> + wv`**: Split window vertically ([W]indow [V]ertical).
*   **`<Leader> + ws`**: Split window horizontally ([W]indow [S]plit).
*   **`<Leader> + wq`** (or **`<Leader> + qq`**): Quit the current window instantly.

#### 3. Blazing Fast Searching (Telescope)
*   **`<Leader> + sf`** *(Search Files)*: Fuzzy find any file in your workspace.
*   **`<Leader> + sg`** *(Search by Grep)*: Live grep for strings everywhere in the project.
*   **`<Leader> + sw`** *(Search Word)*: Search the current word under your cursor.
*   **`<Leader> + <Leader>`**: Quick switch between recent buffers.
*   **`<Leader> + /`**: Fuzzily search content directly inside the current buffer.

#### 4. File Explorer (Neo-tree)
*   **`\` (Backslash)**: Toggle the left-side file tree explorer.
    *   *Within tree*: Press `a` to add a file/dir, `d` to delete, `r` to rename.

#### 5. IDE Superpowers (LSP & Autocomplete)
*   **Autocomplete**: Use arrow keys or `<Ctrl>+n / <Ctrl>+p` to navigate. Press **`Tab`** to accept the suggestion.
*   **`grd`** *(Goto Definition)*: Jump directly to the original definition of a function/variable.
*   **`grr`** *(Goto References)*: View references of where this is used.
*   **`grn`** *(Rename)*: Smartly rename a variable across the entire scope.
*   **`gra`** *(Code Action)*: Get AI/LSP assistance to fix issues (e.g. auto-imports, refactors).

#### 6. Auto-Formatting (Conform)
*   By default, **saving a file (`<Ctrl> + s`)** automatically formats the code to specific language standards.
*   **`<Leader> + f`**: Trigger manual forced formatting at any time.

#### 7. Git Integration (Gitsigns)
*   **`]c` / `[c`**: Jump quickly between next/previous Git changed blocks (hunks).
*   **`<Leader> + hp`** *(Hunk Preview)*: Check out what the code previously looked like inline.
*   **`<Leader> + tb`** *(Toggle Blame)*: Toggle faded text identifying the commit author & timestamp on the current line.

#### 8. Super Speed Surrounding (Mini.surround)
*   **Wrap Word (saiw + <char>)**: Hover over a word and rapidly type **`s` -> `a` -> `i` -> `w` -> `"`** (Surround Add Inner Word Quote). 
*   **Delete Wrapper (sd + <char>)**: Hover over a wrapped word and type **`s` -> `d` -> `"`** (Surround Delete Quote). The quotes disappear instantly.
