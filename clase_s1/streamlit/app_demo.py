import streamlit as st
import pandas as pd
import plotly.express as px


st.set_page_config(
    page_title="Desarrollo Humano Global · Streamlit",
    page_icon="🌍",
    layout="wide"
)

st.title("🌍 Desarrollo Humano Global · Streamlit")
st.caption(
    "Caso S1: una organizacion internacional quiere entender "
    "como ha cambiado el desarrollo humano y que regiones deberia mirar primero."
)


@st.cache_data
def cargar_datos():
    url = "https://raw.githubusercontent.com/plotly/datasets/master/gapminder_unfiltered.csv"
    return pd.read_csv(url)


df = cargar_datos()

st.sidebar.header("Filtros del caso")

continentes = st.sidebar.multiselect(
    "Continentes",
    options=sorted(df["continent"].unique()),
    default=sorted(df["continent"].unique())
)

anio = st.sidebar.slider(
    "Año",
    min_value=int(df["year"].min()),
    max_value=int(df["year"].max()),
    value=2007,
    step=5
)

indicador_ranking = st.sidebar.selectbox(
    "Indicador para ranking",
    options=["lifeExp", "gdpPercap", "pop"],
    format_func=lambda x: {
        "lifeExp": "Esperanza de vida",
        "gdpPercap": "PIB per cápita",
        "pop": "Población",
    }[x]
)

df_filtrado = df[
    (df["continent"].isin(continentes)) &
    (df["year"] == anio)
]

if df_filtrado.empty:
    st.warning("No hay datos para los filtros seleccionados. Ajusta los filtros del panel izquierdo.")
    st.stop()

promedio_global = df[df["year"] == anio]["lifeExp"].mean()
desviacion = df_filtrado.copy()
desviacion["desviacion_vs_promedio"] = desviacion["lifeExp"] - promedio_global

col_m1, col_m2, col_m3, col_m4 = st.columns(4)
col_m1.metric("Países analizados", df_filtrado["country"].nunique())
col_m2.metric("Esperanza de vida promedio", f"{df_filtrado['lifeExp'].mean():.1f} años")
col_m3.metric("PIB per cápita promedio", f"${df_filtrado['gdpPercap'].mean():,.0f}")
col_m4.metric("Promedio global de vida", f"{promedio_global:.1f} años")

st.divider()

tab1, tab2, tab3, tab4 = st.tabs([
    "Correlación",
    "Cambio en el tiempo",
    "Ranking y desviación",
    "Distribución y composición",
])

with tab1:
    st.subheader("Correlación: economía y desarrollo")
    fig_scatter = px.scatter(
        df_filtrado,
        x="gdpPercap",
        y="lifeExp",
        size="pop",
        color="continent",
        hover_name="country",
        log_x=True,
        labels={
            "gdpPercap": "PIB per cápita (USD, escala log)",
            "lifeExp": "Esperanza de vida (años)",
            "pop": "Población",
            "continent": "Continente",
        },
        title=f"¿Hay relación entre PIB per cápita y esperanza de vida? · {anio}"
    )
    st.plotly_chart(fig_scatter, use_container_width=True)
    st.caption(
        "Lectura sugerida: si los puntos suben hacia la derecha, "
        "parece haber asociación positiva entre desarrollo económico y esperanza de vida."
    )

with tab2:
    st.subheader("Cambio en el tiempo: esperanza de vida promedio por continente")
    serie_tiempo = (
        df[df["continent"].isin(continentes)]
        .groupby(["year", "continent"], as_index=False)["lifeExp"]
        .mean()
    )
    fig_line = px.line(
        serie_tiempo,
        x="year",
        y="lifeExp",
        color="continent",
        markers=True,
        labels={
            "year": "Año",
            "lifeExp": "Esperanza de vida promedio",
            "continent": "Continente",
        },
        title="¿Qué regiones avanzan más lento en el tiempo?"
    )
    st.plotly_chart(fig_line, use_container_width=True)

with tab3:
    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Ranking")
        ranking = (
            df_filtrado[["country", indicador_ranking]]
            .sort_values(indicador_ranking, ascending=False)
            .head(10)
        )
        fig_rank = px.bar(
            ranking.sort_values(indicador_ranking),
            x=indicador_ranking,
            y="country",
            orientation="h",
            labels={
                "country": "País",
                "lifeExp": "Esperanza de vida",
                "gdpPercap": "PIB per cápita",
                "pop": "Población",
            },
            title="Top 10 según el indicador seleccionado"
        )
        st.plotly_chart(fig_rank, use_container_width=True)

    with col2:
        st.subheader("Desviación frente al promedio global")
        top_desviacion = (
            desviacion[["country", "desviacion_vs_promedio"]]
            .sort_values("desviacion_vs_promedio")
            .tail(5)
        )
        bottom_desviacion = (
            desviacion[["country", "desviacion_vs_promedio"]]
            .sort_values("desviacion_vs_promedio")
            .head(5)
        )
        muestra_desviacion = pd.concat([bottom_desviacion, top_desviacion])
        fig_dev = px.bar(
            muestra_desviacion,
            x="desviacion_vs_promedio",
            y="country",
            orientation="h",
            color="desviacion_vs_promedio",
            color_continuous_scale=["#D96C4F", "#EBD9C8", "#2E7D6D"],
            labels={
                "desviacion_vs_promedio": "Desviación vs promedio global (años)",
                "country": "País",
            },
            title="¿Qué países están por encima o por debajo del promedio global?"
        )
        st.plotly_chart(fig_dev, use_container_width=True)

with tab4:
    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Distribución")
        fig_hist = px.histogram(
            df_filtrado,
            x="lifeExp",
            nbins=20,
            color="continent",
            opacity=0.75,
            labels={"lifeExp": "Esperanza de vida"},
            title="¿Cómo se distribuye la esperanza de vida?"
        )
        st.plotly_chart(fig_hist, use_container_width=True)

    with col2:
        st.subheader("Parte del todo")
        composicion = (
            df_filtrado.groupby("continent", as_index=False)["pop"]
            .sum()
            .sort_values("pop", ascending=False)
        )
        fig_pie = px.pie(
            composicion,
            names="continent",
            values="pop",
            title=f"¿Cómo se reparte la población total? · {anio}"
        )
        st.plotly_chart(fig_pie, use_container_width=True)

st.divider()

st.subheader("Datos detallados")
st.dataframe(
    df_filtrado[["country", "continent", "year", "lifeExp", "gdpPercap", "pop"]]
    .sort_values("lifeExp", ascending=False)
    .rename(columns={
        "country": "País",
        "continent": "Continente",
        "year": "Año",
        "lifeExp": "Esperanza de vida",
        "gdpPercap": "PIB per cápita",
        "pop": "Población",
    })
    .reset_index(drop=True),
    use_container_width=True
)

st.info(
    "Sugerencia para la actividad: cambia el indicador del ranking, el título de una pestaña, "
    "el color de un gráfico o agrega un filtro nuevo."
)
