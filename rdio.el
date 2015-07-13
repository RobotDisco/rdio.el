;;; rdio.el --- Control the OS X Rdio app from within Emacs -*- lexical-binding: t -*-

;; Copyright (C) 2015 Gaelan D'costa

;; Author: Gaelan D'costa <gdcosta@gmail.com>
;; Maintainer: Gaelan D'costa <gdcosta@gmail.com>
;; Version: 0.0.1-pre
;; URL: http://github.com/robotdisco/rdio.el
;; Package-Requires:

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defconst rdio-script-prefix "tell application \"Rdio\" to "
  "This Applescript is how you tell the Rdio app to do anything.")

(defun rdio-tell-app-to (action)
  "Tell the Rdio app to ACTION via the Applescript command line tools."
  (let ((script (concat rdio-script-prefix action)))
    (shell-command-to-string (format "osascript -e %S" script))))

(defun rdio-play-pause-app ()
  "Tell the Rdio app to pause/resume."
  (interactive)
  (rdio-tell-app-to "playpause"))

(defun rdio-play-app ()
  "Tell the Rdio app to start playing."
  (interactive)
  (rdio-tell-app-to "play"))

(defun rdio-pause-app ()
  "Tell the Rdio app to pause."
  (interactive)
  (rdio-tell-app-to "pause"))

(defun rdio-current-track ()
  "Display the track currently playing on Rdio."
  (interactive)
  (let ((current-artist (rdio-tell-app-to "get the artist of current track"))
        (current-track (rdio-tell-app-to "get the name of current track")))
    (message
     (s-collapse-whitespace (format "Rdio is playing: %s - %s" current-artist current-track)))))

(provide 'rdio)

;;; rdio.el ends here
