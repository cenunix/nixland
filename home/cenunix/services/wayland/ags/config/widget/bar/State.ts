export type CatType = "cat_0-symbolic" | "cat_1-symbolic" | "cat_2-symbolic" | "cat_3-symbolic" | "cat_4-symbolic";
export const CAT_CYCLE: CatType[] = ["cat_0-symbolic", "cat_1-symbolic", "cat_2-symbolic", "cat_3-symbolic", "cat_4-symbolic"];
export const CatState = Variable<CatType>(CAT_CYCLE[0] as CatType);