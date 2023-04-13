#!/usr/bin/env zx

$.log = (entry) => {
  // do not dispay stdout
  if (entry.kind === 'stdout') return
  // do not show commands
  if (entry.kind === 'cmd') return
  log(entry)
}

const vaultState = await $`vault token lookup`
if (vaultState.exitCode === 2) {
  await $`vault login`
}
