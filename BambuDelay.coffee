# Bambu Lab A1 mini Start Delay Widget (Compact G4 S90 Dwell Edition)
command: ""

refreshFrequency: false

style: """
  top: 24px
  Left: 24px
  width: 280px
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, sans-serif
  color: #f3f4f6
  z-index: 10

  .widget-card
    background: rgba(17, 24, 39, 0.88)
    backdrop-filter: blur(18px)
    -webkit-backdrop-filter: blur(18px)
    border: 1px solid rgba(55, 65, 81, 0.75)
    border-radius: 16px
    padding: 14px 16px
    box-shadow: 0 18px 36px rgba(0, 0, 0, 0.5)

  .header
    display: flex
    justify-content: space-between
    align-items: center
    margin-bottom: 6px

  .title
    font-size: 0.85rem
    font-weight: 700
    letter-spacing: -0.01em
    color: #f9fafb

  .live-badge
    display: inline-flex
    align-items: center
    gap: 5px
    padding: 3px 8px
    border-radius: 999px
    font-size: 0.65rem
    font-weight: 700
    background: rgba(0, 174, 66, 0.16)
    color: #4ade80
    border: 1px solid rgba(74, 222, 128, 0.3)

  .live-badge.paused
    background: rgba(156, 163, 175, 0.14)
    color: #9ca3af
    border-color: rgba(156, 163, 175, 0.25)

  .dot
    width: 6px
    height: 6px
    border-radius: 50%
    background: #4ade80

  .live-badge.paused .dot
    background: #9ca3af

  .arc-wrap
    position: relative
    width: 100%
    display: flex
    flex-direction: column
    align-items: center
    margin: 2px 0 8px

  .arc-svg
    width: 220px
    height: 112px
    overflow: visible

  .arc-center
    position: absolute
    bottom: 6px
    text-align: center

  .arc-countdown
    font-size: 1.15rem
    font-weight: 800
    font-variant-numeric: tabular-nums
    color: #ffffff
    line-height: 1.1

  .arc-sub
    font-size: 0.68rem
    color: #9ca3af
    margin-top: 2px

  .row-grid
    display: grid
    grid-template-columns: 1fr 1fr
    gap: 8px
    margin-bottom: 8px

  .input-box
    background: rgba(9, 13, 22, 0.72)
    border: 1px solid rgba(55, 65, 81, 0.7)
    border-radius: 10px
    padding: 8px 10px

  .input-top
    display: flex
    justify-content: space-between
    align-items: center
    margin-bottom: 4px

  .input-label
    font-size: 0.64rem
    font-weight: 600
    text-transform: uppercase
    letter-spacing: 0.04em
    color: #9ca3af

  .live-check
    display: inline-flex
    align-items: center
    gap: 3px
    font-size: 0.64rem
    color: #d1d5db
    cursor: pointer

  .live-check input
    accent-color: #00ae42
    width: 11px
    height: 11px
    margin: 0
    cursor: pointer

  input[type="time"]
    width: 100%
    background: transparent
    border: none
    color: #f9fafb
    font-size: 0.92rem
    font-weight: 700
    font-variant-numeric: tabular-nums
    padding: 0
    outline: none

  input[type="time"]:disabled
    opacity: 0.9

  .presets
    display: flex
    gap: 5px
    margin-bottom: 10px

  .preset-btn
    flex: 1
    background: rgba(9, 13, 22, 0.72)
    border: 1px solid rgba(55, 65, 81, 0.7)
    color: #9ca3af
    font-size: 0.68rem
    font-weight: 600
    padding: 4px 0
    border-radius: 6px
    cursor: pointer

  .preset-btn:hover
    color: #ffffff
    border-color: #6b7280

  .gcode-bar
    background: rgba(6, 9, 16, 0.85)
    border: 1px solid rgba(55, 65, 81, 0.75)
    border-radius: 10px
    padding: 8px 10px
    display: flex
    justify-content: space-between
    align-items: center
    gap: 8px

  .gcode-info
    display: flex
    flex-direction: column
    min-width: 0

  .gcode-code
    font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace
    font-size: 0.76rem
    font-weight: 700
    color: #4ade80
    white-space: nowrap
    overflow: hidden
    text-overflow: ellipsis

  .gcode-meta
    font-size: 0.63rem
    color: #9ca3af
    margin-top: 1px

  .copy-btn
    background: #00ae42
    color: #ffffff
    border: none
    border-radius: 7px
    padding: 6px 10px
    font-size: 0.72rem
    font-weight: 700
    cursor: pointer
    white-space: nowrap

  .copy-btn:hover
    background: #009438
"""

render: -> """
  <div class="widget-card">
    <div class="header">
      <span class="title">Bambu Start Delay</span>
      <span class="live-badge" id="bd-live-badge">
        <span class="dot"></span>
        <span id="bd-live-text">LIVE</span>
      </span>
    </div>

    <div class="arc-wrap">
      <svg class="arc-svg" viewBox="0 0 220 112">
        <defs>
          <linearGradient id="bdArcGrad" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stop-color="#00ae42" />
            <stop offset="100%" stop-color="#4ade80" />
          </linearGradient>
        </defs>
        <path d="M 18 100 A 92 92 0 0 1 202 100" fill="none" stroke="rgba(55,65,81,0.55)" stroke-width="8" stroke-linecap="round" />
        <path id="bd-arc-progress" d="M 18 100 A 92 92 0 0 1 202 100" fill="none" stroke="url(#bdArcGrad)" stroke-width="8" stroke-linecap="round" stroke-dasharray="289.03" stroke-dashoffset="144" />
        <circle id="bd-arc-knob" cx="110" cy="8" r="5.5" fill="#ffffff" stroke="#00ae42" stroke-width="2.5" />
      </svg>
      <div class="arc-center">
        <div class="arc-countdown" id="bd-countdown">--:--:--</div>
        <div class="arc-sub" id="bd-first-layer">1st layer ~06:07</div>
      </div>
    </div>

    <div class="row-grid">
      <div class="input-box">
        <div class="input-top">
          <span class="input-label">Start</span>
          <label class="live-check">
            <input type="checkbox" id="bd-live-toggle" checked />
            Live
          </label>
        </div>
        <input type="time" id="bd-start-time" step="1" disabled />
      </div>

      <div class="input-box">
        <div class="input-top">
          <span class="input-label">Target</span>
        </div>
        <input type="time" id="bd-target-time" step="1" value="06:00:00" />
      </div>
    </div>

    <div class="presets">
      <button type="button" class="preset-btn" data-t="06:00:00">06:00</button>
      <button type="button" class="preset-btn" data-t="07:00:00">07:00</button>
      <button type="button" class="preset-btn" data-t="08:00:00">08:00</button>
      <button type="button" class="preset-btn" data-t="12:00:00">12:00</button>
    </div>

    <div class="gcode-bar">
      <div class="gcode-info">
        <span class="gcode-code" id="bd-gcode-preview">G4 S90 × 306</span>
        <span class="gcode-meta" id="bd-gcode-meta">27,540s total dwell</span>
      </div>
      <button type="button" class="copy-btn" id="bd-copy-btn">Copy G-code</button>
    </div>
  </div>
"""

afterRender: (domEl) ->
  startInput = domEl.querySelector('#bd-start-time')
  targetInput = domEl.querySelector('#bd-target-time')
  liveToggle = domEl.querySelector('#bd-live-toggle')
  liveBadge = domEl.querySelector('#bd-live-badge')
  liveText = domEl.querySelector('#bd-live-text')
  countdownEl = domEl.querySelector('#bd-countdown')
  firstLayerEl = domEl.querySelector('#bd-first-layer')
  arcProgress = domEl.querySelector('#bd-arc-progress')
  arcKnob = domEl.querySelector('#bd-arc-knob')
  gcodePreview = domEl.querySelector('#bd-gcode-preview')
  gcodeMeta = domEl.querySelector('#bd-gcode-meta')
  copyBtn = domEl.querySelector('#bd-copy-btn')
  presetBtns = domEl.querySelectorAll('.preset-btn')

  ARC_LEN = 289.03
  currentGcodeBlock = ''

  pad = (n) -> String(n).padStart(2, '0')

  parseSec = (str) ->
    parts = str.split(':')
    h = Number(parts[0]) or 0
    m = Number(parts[1]) or 0
    s = Number(parts[2]) or 0
    h * 3600 + m * 60 + s

  formatClock = (sec) ->
    w = ((sec % 86400) + 86400) % 86400
    h = Math.floor(w / 3600)
    m = Math.floor((w % 3600) / 60)
    "#{pad(h)}:#{pad(m)}"

  buildG4Block = (totalSeconds, targetLabel) ->
    fullChunks = Math.floor(totalSeconds / 90)
    remainder = totalSeconds % 90
    lines = [";===== Delay start until #{targetLabel} (#{totalSeconds}s) ====="]
    i = 0
    while i < fullChunks
      lines.push("G4 S90")
      i++
    if remainder > 0
      lines.push("G4 S#{remainder}")
    lines.push(";===== End delay =====")
    lines.join('\n')

  updateCalc = ->
    return unless startInput.value and targetInput.value
    startSec = parseSec(startInput.value)
    targetSec = parseSec(targetInput.value)
    diffSec = targetSec - startSec
    diffSec += 86400 if diffSec <= 0

    h = Math.floor(diffSec / 3600)
    m = Math.floor((diffSec % 3600) / 60)
    s = diffSec % 60
    countdownEl.textContent = "#{h}h #{pad(m)}m #{pad(s)}s"
    firstLayerEl.textContent = "1st layer ~#{formatClock(targetSec + 420)}"

    ratio = Math.min(1, Math.max(0.02, diffSec / 86400))
    arcProgress.style.strokeDashoffset = (ARC_LEN * (1 - ratio)).toFixed(2)
    angle = Math.PI * (1 - ratio)
    kx = 110 + 92 * Math.cos(angle)
    ky = 100 - 92 * Math.sin(angle)
    arcKnob.setAttribute('cx', kx.toFixed(1))
    arcKnob.setAttribute('cy', ky.toFixed(1))

    fullChunks = Math.floor(diffSec / 90)
    rem = diffSec % 90
    summary = if rem > 0 then "G4 S90 ×#{fullChunks} + S#{rem}" else "G4 S90 ×#{fullChunks}"
    gcodePreview.textContent = summary
    gcodeMeta.textContent = "#{diffSec.toLocaleString()}s dwell (#{fullChunks + (if rem > 0 then 1 else 0)} lines)"
    currentGcodeBlock = buildG4Block(diffSec, targetInput.value.slice(0, 5))

  syncLive = ->
    now = new Date()
    startInput.value = "#{pad(now.getHours())}:#{pad(now.getMinutes())}:#{pad(now.getSeconds())}"
    updateCalc()

  if window._bdTimer
    clearInterval(window._bdTimer)

  setLive = (enabled) ->
    startInput.disabled = enabled
    if enabled
      liveBadge.classList.remove('paused')
      liveText.textContent = 'LIVE'
      syncLive()
      window._bdTimer = setInterval(syncLive, 1000)
    else
      liveBadge.classList.add('paused')
      liveText.textContent = 'MANUAL'
      clearInterval(window._bdTimer)
      window._bdTimer = null

  liveToggle.addEventListener 'change', (e) -> setLive(e.target.checked)
  startInput.addEventListener 'input', updateCalc
  targetInput.addEventListener 'input', updateCalc

  presetBtns.forEach (btn) ->
    btn.addEventListener 'click', ->
      targetInput.value = btn.getAttribute('data-t')
      updateCalc()

  copyBtn.addEventListener 'click', ->
    navigator.clipboard.writeText(currentGcodeBlock).then ->
      orig = copyBtn.textContent
      copyBtn.textContent = 'Copied!'
      setTimeout (-> copyBtn.textContent = orig), 1500

  setLive(true)
