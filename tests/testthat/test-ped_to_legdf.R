new_par <- list(
    bg = "transparent",
    usr = c(0, 1, 0, 1),
    fig = c(0, 1, 0, 1),
    mai = c(0, 0, 0, 0),
    mar = c(0, 0, 0, 0),
    pin = c(7, 7),
    plt = c(0, 1, 0, 1),
    xaxp = c(0, 4, 4),
    xpd = FALSE,
    yaxp = c(2, 2, 1),
    fin = c(7, 7),
    pty = "m"
)

test_that("Pedigree legend works", {
    data("sampleped")
    sampleped$val_num <- as.numeric(sampleped$id)
    ped <- Pedigree(sampleped)
    ped <- ped[ped(ped, "famid") == "1"]
    famid(ped(ped))[13] <- "1"
    ped2 <- ped[ped(ped, "id") != "1_113"]

    p1 <- align(ped)
    p2 <- align(ped2)

    # TODO expect_equal(p1, p2)

    ped <- generate_colors(ped, add_to_scale = TRUE, "avail", mods_aff = TRUE)
    ped <- generate_colors(ped,
        add_to_scale = TRUE, "val_num", threshold = 115,
        colors_aff = c("pink", "purple"), keep_full_scale = TRUE
    )
    lst <- ped_to_legdf(ped, boxh = 1, boxw = 1, cex = 0.8)
    expect_snapshot(lst)

    vdiffr::expect_doppelganger("Legend alone",
        function() {
            suppressWarnings(plot_legend(
                ped, boxh = 0.07, boxw = 0.07, cex = 0.7,
                leg_loc = c(0, 0.9, 0, 0.9), adjx = 0, adjy = 0
            ))
        }
    )

    vdiffr::expect_doppelganger("Plot with legend",
        function() {
            suppressWarnings(plot(
                ped[!is.na(famid(ped(ped)))],
                cex = 0.8, symbolsize = 1.5, aff_mark = FALSE,
                legend = TRUE, leg_cex = 0.8, leg_symbolsize = 0.01,
                leg_loc = c(0, 0.8, 0, 0.25),
                ped_par = list(oma = c(12, 1, 1, 1), mar = rep(0, 4)),
                leg_par = list(oma = c(1, 1, 1, 1), mar = rep(0, 4))
            ))
        }
    )
})
