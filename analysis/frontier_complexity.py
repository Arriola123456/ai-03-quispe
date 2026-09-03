"""Complexity extension of Quispe & Xu (2026): the verification bottleneck.

Thresholds with task complexity c >= 0:
    T^S(c) = T^S + chi c^2/2 + psi c            (delegation removes the linear term psi c)
    T^D(c) = T^D + chi c^2/2 + eta c^2/2 + (rho/2)(nu c^2/2)
so the delegation advantage is
    B(c) = T^S(c) - T^D(c) = B + psi c - theta c^2/2,   theta = eta + rho nu / 2,
which peaks at c* = psi/theta and turns negative beyond the larger root cbar.
The benchmark theta = 0 (no verification/risk bottleneck) gives B + psi c.

Left panel: the (omega, c) plane with the three regions of the extended model.
Right panel: B(c) with and without the bottleneck.
"""
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

# thresholds without complexity (same illustrative parameters as cumulative_effect.py)
TS, TD = 0.91, 0.5309
B0 = TS - TD
chi, psi, eta, nu, rho = 0.6, 0.5, 0.4, 0.3, 2.0
theta = eta + rho * nu / 2
cstar = psi / theta
cbar = (psi + np.sqrt(psi**2 + 2 * theta * B0)) / theta

def T_S(c):
    return TS + chi / 2 * c**2 + psi * c

def T_D(c):
    return TD + (chi + theta) / 2 * c**2

def B(c, th=theta):
    return B0 + psi * c - th / 2 * c**2

c = np.linspace(0, 2.6, 400)
fig, ax = plt.subplots(1, 2, figsize=(10.5, 3.9))

# --- left: frontier in the (omega, c) plane -------------------------------
a = ax[0]
wmax = 4.0
a.fill_betweenx(c, T_S(c), wmax, color="tab:blue", alpha=0.12, label=r"feasible solo: $\omega \geq T^S(c)$")
band_mask = c <= cbar
a.fill_betweenx(c[band_mask], T_D(c[band_mask]), T_S(c[band_mask]), color="orange", alpha=0.35,
                label=r"only with delegation: $T^D(c) \leq \omega < T^S(c)$")
a.plot(T_S(c), c, color="tab:blue", lw=2, label=r"$\omega = T^S(c)$")
a.plot(T_D(c), c, color="tab:red", lw=2, label=r"$\omega = T^D(c)$")
a.axhline(cstar, color="gray", ls=":", lw=1)
a.axhline(cbar, color="gray", ls="--", lw=1)
a.text(wmax - 0.05, cstar + 0.04, r"$c^* = \psi/\theta$", ha="right", fontsize=8, color="gray")
a.text(wmax - 0.05, cbar + 0.04, r"$\bar c$: band closes", ha="right", fontsize=8, color="gray")
a.set_xlim(0, wmax); a.set_ylim(0, 2.6)
a.set_xlabel(r"opportunity value $\omega$"); a.set_ylabel(r"task complexity $c$")
a.set_title("Frontier in the $(\\omega, c)$ plane")
a.legend(fontsize=7, loc="upper left"); a.grid(alpha=.3)

# --- right: B(c) with and without the bottleneck --------------------------
b = ax[1]
b.plot(c, B(c), color="tab:red", lw=2, label=r"$B(c) = B + \psi c - \theta c^2/2$  (bottleneck)")
b.plot(c, B(c, 0.0), color="tab:blue", lw=2, ls="--", label=r"benchmark $\theta = 0$: $B + \psi c$")
b.axhline(0, color="k", lw=0.8)
b.axvline(cstar, color="gray", ls=":", lw=1); b.axvline(cbar, color="gray", ls="--", lw=1)
b.text(cstar, B(cstar) + 0.05, r"$c^*$", ha="center", fontsize=9)
b.text(cbar, 0.06, r"$\bar c$", ha="center", fontsize=9)
b.set_xlabel(r"task complexity $c$"); b.set_ylabel(r"delegation advantage $B(c)$")
b.set_title("Width of the activation band"); b.legend(fontsize=7, loc="lower left"); b.grid(alpha=.3)
b.set_xlim(0, 2.6)

fig.tight_layout()
fig.savefig("analysis/figures/frontier_complexity.pdf")
fig.savefig("analysis/figures/frontier_complexity.png", dpi=160)
print(f"B0={B0:.4f} theta={theta:.3f} c*={cstar:.3f} cbar={cbar:.3f} B(c*)={B(cstar):.4f}")
