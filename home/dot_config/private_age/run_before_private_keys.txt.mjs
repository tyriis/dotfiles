#!/usr/bin/env zx

$.log = (entry) => {
  if (entry.kind === 'stdout') return
  // if (entry.kind === 'cmd') return
  log(entry)
}

const vaultState = await $`vault token lookup`
if (vaultState.exitCode === 2) {
    await $`vault login`
}
