version = '1.0.1'
xplr.config.modes.builtin.default.key_bindings.on_key.p = {
  help = "preview",
  messages = {
    {
      BashExec = "~/.config/xplr/scripts/preview.sh ${XPLR_FOCUS_PATH}"
    }
  }
}
