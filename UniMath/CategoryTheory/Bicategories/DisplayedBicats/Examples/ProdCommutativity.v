(* ******************************************************************************* *)
(** * Commutativity of direct product of displayed bicategories.
 ********************************************************************************* *)

Require Import UniMath.Foundations.All.
Require Import UniMath.MoreFoundations.PartA.
Require Import UniMath.CategoryTheory.Core.Categories.
Require Import UniMath.CategoryTheory.Core.Functors.
Require Import UniMath.CategoryTheory.DisplayedCats.Auxiliary.
Require Import UniMath.CategoryTheory.DisplayedCats.Core.
Require Import UniMath.CategoryTheory.DisplayedCats.Constructions.
Require Import UniMath.CategoryTheory.Bicategories.Bicategories.Bicat. Import Bicat.Notations.
Require Import UniMath.CategoryTheory.Bicategories.Bicategories.Examples.Initial.
Require Import UniMath.CategoryTheory.Bicategories.Bicategories.Examples.Final.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.DispBicat. Import DispBicat.Notations.
Require Import UniMath.CategoryTheory.Bicategories.Bicategories.Univalence.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.DispInvertibles.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.DispAdjunctions.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.DispUnivalence.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.DispPseudofunctor.
Require Import UniMath.CategoryTheory.Bicategories.DisplayedBicats.Examples.Prod.
Require Import UniMath.CategoryTheory.Bicategories.PseudoFunctors.Display.PseudoFunctorBicat.
Require Import UniMath.CategoryTheory.Bicategories.PseudoFunctors.PseudoFunctor.
Require Import UniMath.CategoryTheory.Bicategories.PseudoFunctors.Examples.Identity.

Local Open Scope cat.
Local Open Scope mor_disp_scope.

Definition transportf_make_dirprod
           (A : UU) (B B' : A → UU)
           (a1 a2 : A) (b : B a1) (b' : B' a1) (p : a1 = a2)
  : transportf (λ a : A, B a × B' a) p (make_dirprod b b') =
    make_dirprod (transportf B p b) (transportf B' p b').
Proof.
  induction p.
  apply idpath.
Defined.

Section DirProdCommutative.
  Context {B : bicat}.
  Variable (D1 D2 : disp_bicat B).

  Definition disp_swap_data
    : disp_psfunctor_data (disp_dirprod_bicat D1 D2) (disp_dirprod_bicat D2 D1) (ps_id_functor B).
  Proof.
    use make_disp_psfunctor_data.
    - intros a aa.
      exact (pr2 aa ,, pr1 aa).
    - intros a b f xx yy ff.
      exact (pr2 ff ,, pr1 ff).
    - intros a b f g α xx yy ff gg αα.
      exact (pr2 αα ,, pr1 αα).
    - intros a aa.
      exact (disp_id2_invertible_2cell _).
    - intros a b c f g aa bb cc ff gg.
      exact (disp_id2_invertible_2cell _).
  Defined.

  Definition disp_swap_laws : is_disp_psfunctor _ _ _ disp_swap_data.
  Proof.
    repeat use tpair.
    - intros a b f aa bb ff.
      cbn.
      unfold transportb.
      rewrite transportf_set.
      apply idpath.
      apply B.
    - intros a b f g h α β aa bb ff gg hh αα ββ.
      cbn.
      unfold transportb.
      rewrite transportf_set.
      apply idpath.
      apply B.
    - intros a b f aa bb ff.
      cbn.
      unfold transportb.
      rewrite transportf_make_dirprod.
      use pathsdirprod.
      + rewrite disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_rwhisker.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        unfold transportb.
        rewrite !transport_f_f.
        rewrite transportf_set.
        apply idpath.
        apply B.
      + rewrite disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_rwhisker.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        unfold transportb.
        rewrite !transport_f_f.
        rewrite transportf_set.
        apply idpath.
        apply B.
    - intros a b f aa bb ff.
      cbn.
      unfold transportb.
      rewrite transportf_make_dirprod.
      use pathsdirprod.
      + rewrite disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_lwhisker_id2.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        unfold transportb.
        rewrite !transport_f_f.
        rewrite transportf_set.
        apply idpath.
        apply B.
      + rewrite disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_lwhisker_id2.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        unfold transportb.
        rewrite! transport_f_f.
        rewrite transportf_set.
        apply idpath.
        apply B.
    - intros a b c d f g h aa bb cc dd ff gg hh.
      cbn.
      unfold transportb.
      rewrite transportf_make_dirprod.
      use pathsdirprod.
      + rewrite !disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_rwhisker.
        rewrite disp_lwhisker_id2.
        unfold transportb.
        rewrite !disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        rewrite disp_mor_transportf_prewhisker.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
      + rewrite !disp_id2_right.
        unfold transportb.
        rewrite disp_mor_transportf_postwhisker.
        rewrite disp_id2_rwhisker.
        rewrite disp_lwhisker_id2.
        unfold transportb.
        rewrite !disp_mor_transportf_postwhisker.
        rewrite disp_id2_left.
        rewrite disp_mor_transportf_prewhisker.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
    - intros a b c f g1 g2 α aa bb cc ff gg1 gg2 αα.
      cbn.
      unfold transportb.
      rewrite transportf_make_dirprod.
      use pathsdirprod.
      + rewrite disp_id2_left.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
      + rewrite disp_id2_left.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
    - intros a b c f1 f2 g α aa bb cc ff1 ff2 gg αα.
      cbn.
      unfold transportb.
      rewrite transportf_make_dirprod.
      use pathsdirprod.
      + rewrite disp_id2_left.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
      + rewrite disp_id2_left.
        rewrite disp_id2_right.
        unfold transportb.
        rewrite !transport_f_f.
        refine (transportf_paths (λ α, _ ==>[ α ] _) _ _).
        apply B.
  Qed.

  Definition disp_swap
    : disp_psfunctor (disp_dirprod_bicat D1 D2) (disp_dirprod_bicat D2 D1) (ps_id_functor B)
    := disp_swap_data ,, disp_swap_laws.

End DirProdCommutative.
