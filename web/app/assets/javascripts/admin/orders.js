// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    $(".btn-danger").attr({'data-toggle':			"confirmation",
        'data-btn-ok-label':		"Continuer",
        'data-btn-ok-class':		"btn-success",
        'data-btn-cancel-label':	"Annuler",
        'data-btn-cancel-class':	"btn-danger",
        'data-title':					"Voulez-vous continuer?",
        'data-content':				"Pour spécifier une raison de refus, passez par le formulaire de modification."});

    /*$('[data-toggle=confirmation]').confirmation({
        rootSelector: '[data-toggle=confirmation]',
        // other options
    });*/

    $('#orders').DataTable({
        columnDefs: [
            { targets: 'no-sort', orderable: false }
        ],
        "order": [[ 3, "desc" ]],
        "language": {
            processing:     "Traitement en cours...",
            search:         "Rechercher&nbsp;:",
            lengthMenu:    "Afficher _MENU_ &eacute;l&eacute;ments",
            info:           "Affichage de l'&eacute;lement _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
            infoEmpty:      "Affichage de l'&eacute;lement 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
            infoFiltered:   "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
            infoPostFix:    "",
            loadingRecords: "Chargement en cours...",
            zeroRecords:    "Aucun &eacute;l&eacute;ment &agrave; afficher",
            emptyTable:     "Aucune donnée disponible dans le tableau",
            paginate: {
                first:      "Premier",
                previous:   "Pr&eacute;c&eacute;dent",
                next:       "Suivant",
                last:       "Dernier"
            },
            aria: {
                sortAscending:  ": activer pour trier la colonne par ordre croissant",
                sortDescending: ": activer pour trier la colonne par ordre décroissant"
            }
        }
    });

    /*var isSuccess = getUrlParameter('modif');
    if (isSuccess == "success")
        $(".alert-success").css("display", "block");
    if (isSuccess == "error")
        $(".alert-danger").css("display", "block");*/

    // Enable tooltip
    //$('[data-toggle="tooltip"]').tooltip();

    // Remove sorting on first column
    $("#orders thead").find("th").eq(0).removeClass("sorting_asc");

    // Activate/Deactivate solo action buttons according to status
    $("#orders tbody tr").each(function() {
        if ($(this).find(".status").text() == "Approuver") {
            $(this).find(".btn-success").addClass("disabled");
            $(this).find(".btn-light").addClass("disabled");
            $(this).find(".btn-danger").removeClass("disabled");
        }
        if ($(this).find(".status").text() == "Refusé") {
            $(this).find(".btn-success").removeClass("disabled");
            $(this).find(".btn-light").removeClass("disabled");
            $(this).find(".btn-danger").addClass("disabled");
        }
    });

    // Activate/Deactivate checkboxes and selected action buttons
    $("#checkAll").change(function() {
        if ($(this).is(":checked")) {
            $("#approuveSelected").prop("disabled", false);
            $("#refuseSelected").prop("disabled", false);
            $(".checkRow").prop("checked", true);
        } else {
            $("#approuveSelected").prop("disabled", true);
            $("#refuseSelected").prop("disabled", true);
            $(".checkRow").prop("checked", false);
        }
    });
    $(".checkRow").change(function() {
        if ($(this).is(":checked")) {
            $("#approuveSelected").prop("disabled", false);
            $("#refuseSelected").prop("disabled", false);
            if ($(".checkRow:checked").length == $("#orders tbody tr").length)
                $("#checkAll").prop("checked", true);
        } else {
            if ($(".checkRow:checked").length == 0) {
                $("#approuveSelected").prop("disabled", true);
                $("#refuseSelected").prop("disabled", true);
                $("#checkAll").prop("checked", false);
            }
        }
    });

    $("#popopOverlay").click(function() {
        $(this).css("display", "none");
        $("#popup").css("display", "none");
    });
});