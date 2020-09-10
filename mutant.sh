#/usr/bin/bash -ex

bundle exec mutant                           \
  --zombie                                   \
  --ignore-subject Concord#define_equalizer  \
  --ignore-subject Concord#define_initialize \
  --ignore-subject Concord#define_readers    \
  --ignore-subject Concord#included          \
  --ignore-subject Concord::Public#included  \
  -- 'Concord*'
