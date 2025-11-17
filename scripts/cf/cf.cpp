#include <bits/stdc++.h>
#include <cstdint>

using namespace std;

using ll = int64_t;
using ld = uint64_t;

template <class T> using pp = pair<T, T>;
using ip = pp<ll>;

template <class T> using vec = vector<T>;
template <class T, size_t N> using arr = array<T, N>;

template <typename A, typename B>
ostream &operator<<(ostream &os, const pair<A, B> &p) {
  return os << '(' << p.first << ", " << p.second << ')';
}
template <typename... Args>
ostream &operator<<(ostream &os, const tuple<Args...> &t) {
  os << '(';
  apply(
      [&os](const Args &...args) {
        size_t n = 0;
        ((os << args << (++n != sizeof...(Args) ? ", " : "")), ...);
      },
      t);
  return os << ')';
}

template <typename T> void pv(const T &v, int start = 0, int end = -1) {
  if (end < 0)
    end = int(v.size());

  for (int i = start; i < end; i++)
    cout << v[i] << (i < end - 1 ? ' ' : '\n');
}

#define all(c) (c).begin(), (c).end()

void solve();

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);

  int t;
  cin >> t;

  while (t--) {
    solve();
  }
}

void solve() {

}
