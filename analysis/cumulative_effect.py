"""Proposition 3 endpoint check: cumulative-language effect in the closed-frontier
benchmark p1 = 0 < p2, Delta C(s) = |U| * (1 - (1 - p2)^(s+1)).

At p2 = 1 the effect is constant (= |U|): the printed 'strictly increasing and
concave' claim needs p2 < 1. Also plots the activation band of Proposition 2."""
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

U = 5
s = np.arange(0, 13)
fig, ax = plt.subplots(1, 2, figsize=(10, 3.6))
for p2, ls in [(0.15, "-"), (0.4, "-"), (0.8, "-"), (1.0, "--")]:
    ax[0].plot(s, U * (1 - (1 - p2) ** (s + 1)), ls, marker="o", ms=3,
               label=f"$p^2 = {p2}$" + ("  (saturates)" if p2 == 1.0 else ""))
ax[0].set_xlabel("event-time horizon $s$"); ax[0].set_ylabel(r"$\Delta C_i(s)$, $|U_i|=5$")
ax[0].set_title("Prop. 3, closed frontier $p^1=0$"); ax[0].legend(fontsize=8); ax[0].grid(alpha=.3)

# activation band: thresholds from the model with illustrative parameters
b, s_, mu, prec, rho = 1.0, 0.2, 0.5, 4.0, 2.0
gam, rC = 1.0, 0.3
lam, a, z, kap, rD, sig = 0.7, 1.2, 1.0, 0.25, 0.1, 0.05
TS = b - s_ * mu + rho * s_**2 / (2 * prec)
TC = TS - (gam * s_ - rC)           # gam*s - rC = -0.1 <= 0 : Assumption 1 holds
T1 = min(TS, TC)
TD = b - (1 - lam) * s_ * mu - lam * a * z + kap + rD + rho / 2 * ((1 - lam)**2 * s_**2 / prec + sig)
w = np.linspace(-0.5, 2.0, 600)
Z1 = (w >= T1).astype(float); Z2 = (w >= min(T1, TD)).astype(float)
ax[1].step(w, Z1, where="post", label="$Z^1$ (menu S,C)")
ax[1].step(w, Z2 + 0.03, where="post", label="$Z^2$ (menu S,C,D)")
ax[1].axvspan(TD, T1, color="orange", alpha=.25, label=f"band $[T^D,T^S)$ = [{TD:.2f}, {T1:.2f})")
ax[1].set_xlabel(r"opportunity $\omega$"); ax[1].set_yticks([0, 1]); ax[1].set_title("Prop. 2, activation band")
ax[1].legend(fontsize=8, loc="center right"); ax[1].grid(alpha=.3)
fig.tight_layout(); fig.savefig("analysis/figures/prop2_prop3.pdf"); fig.savefig("analysis/figures/prop2_prop3.png", dpi=160)
print(f"TS={TS:.4f} TC={TC:.4f} T1={T1:.4f} TD={TD:.4f} B={T1-TD:.4f}")
