#!/usr/bin/env zx

$.log = (entry) => {
  // do not dispay stdout
  if (entry.kind === 'stdout') return
  // do not show commands
  if (entry.kind === 'cmd') return
  log(entry)
}

try {
  await $`vault token lookup`
} catch (error) {
  if (error.message.indexOf('permission denied') !== -1) {
    await $`vault login`
  } else {
    process.exit(1)
  }
}
