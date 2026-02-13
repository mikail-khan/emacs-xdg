# emacs-xdg

A minimal, modern, **XDG-compliant Emacs configuration** built for Emacs 30+.

This config is:

* Modular and easy to extend
* Fully XDG directory compliant
* Designed around built-in Emacs features
* Uses `eglot` instead of heavy LSP layers
* Uses `org-roam` with **per-repository knowledge bases**
* Uses the official **Modus themes** with automatic light/dark switching

---

# Features

## Core

* XDG-compliant directory layout
* Modular architecture (`core/` and `modules/`)
* Fast startup tuning
* Native Emacs completion stack

## Development

* `eglot` for LSP
* `flymake` for diagnostics
* `project.el` integration
* `magit` for Git

## Completion stack

* `vertico`
* `orderless`
* `marginalia`
* `consult`
* `corfu`

## UI

* Official `modus-operandi` (light)
* Official `modus-vivendi` (dark)
* Automatic switching by time of day

---

# XDG Layout

This config follows the XDG base directory specification.

| Type   | Location               |
| ------ | ---------------------- |
| Config | `~/.config/emacs`      |
| Data   | `~/.local/share/emacs` |
| Cache  | `~/.cache/emacs`       |

---

# Installation

## 1. Remove old Emacs configs (optional but recommended)

```bash
pkill emacs || true
rm -rf ~/.emacs.d
rm -rf ~/.config/emacs
rm -rf ~/.local/share/emacs
rm -rf ~/.cache/emacs
```

---

## 2. Clone the repo

```bash
git clone https://github.com/USERNAME/emacs-xdg.git ~/.config/emacs
```

Replace `USERNAME` with your GitHub username.

---

## 3. Start Emacs

```bash
emacs
```

On first launch:

* Packages install automatically
* Completion stack activates
* Modus theme loads
* System is ready to use

---

# Theme behavior

The Modus theme switches automatically:

| Time        | Theme                    |
| ----------- | ------------------------ |
| 07:00–17:59 | Light (`modus-operandi`) |
| 18:00–06:59 | Dark (`modus-vivendi`)   |

---

# Config structure

```
~/.config/emacs
├── early-init.el
├── init.el
├── lisp
│   ├── core
│   │   ├── core-keys.el
│   │   ├── core-packages.el
│   │   ├── core-perf.el
│   │   └── core-ui.el
│   └── modules
│       ├── mod-completion.el
│       ├── mod-eglot.el
│       ├── mod-org.el
│       ├── mod-project.el
│       ├── mod-ui.el
│       └── mod-vc.el
├── etc
├── local.el
└── README.md
```

---

# Updating packages

Inside Emacs:

```
M-x package-refresh-contents
M-x package-upgrade-all
```

---

# Machine-specific settings

Use:

```
~/.config/emacs/local.el
```

Example:

```elisp
(setq user-full-name "Your Name")
(setq user-mail-address "you@example.com")
```

This file can be ignored in Git.

---

# Requirements

* Emacs 30+ recommended
* Git
* A modern terminal or GUI environment

---

# License

See the `LICENSE` file in this repository.
