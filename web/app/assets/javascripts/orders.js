// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

    var patchGroup = $("#patch_preview p span").eq(0);
    var patchSemester = $("#patch_preview p span").eq(1);
    var patchYear = $("#patch_preview p span").eq(2);

// Fill year with default value
    fillYearSelect(2);
// Force year to show at loading
    $("#year").parent().parent().css("display", "flex");
// Force check radio
    $("#patch_Implication").is(':checked')

// Toggle inputs
    $(".patchtype").click(function () {

        console.log("change trigger - " + $("#patch_Graduation").is(':checked'));

        if ($("#patch_Implication").is(':checked')) {
            // Hide unecessary input, show other
            $(".patch2").css("display", "none");
            $(".patch3").css("display", "none");
            $(".patch1").css("display", "flex");

            // Clean patch preview
            $("#patch_preview").removeClass();
            patchGroup.text("-");
            patchSemester.text("");
            patchYear.text("-");
            $("#founder").prop('checked', false);

            // Set required
            $(".patch1 input").prop('required', true);
            $("#year").prop('required', true);

            // Change patch preview color
            $("#patch_preview").addClass("year_odd");

            fillYearSelect(2);
        }

        // Patch Graduation
        if ($("#patch_Graduation").is(':checked')) {
            // Hide unecessary input, show other
            $(".patch1").css("display", "none");
            $(".patch3").css("display", "none");
            $(".patch2").css("display", "flex");
            console.log("graduation");

            // Clean patch preview
            $("#patch_preview").removeClass();
            patchGroup.text("-");
            patchSemester.text("");
            patchYear.text("-");

            // Change patch preview color
            $("#patch_preview").addClass("golden");

            fillYearSelect(1);
        }

        // Patch Personalisée
        if ($("#patch_Custom").is(':checked')) {
            // Hide unecessary input, show other
            $(".patch1").css("display", "none");
            $(".patch2").css("display", "none");
            $(".patch3").css("display", "flex");

            // Clean patch preview
            $("#patch_preview").removeClass();
            patchGroup.text("-");
            patchSemester.text("");
            patchYear.text("");

            // Change patch preview color
            $("#patch_preview").addClass("perso");
        }
    });


// Change text value in patch display
    $("#group").change(function () {
        var content = $(this).children(':selected').text();
        patchGroup.text(content);

        if (content.indexOf("ORG") >= 0) {
            $("#semester").prop('disabled', false);
            patchSemester.text($("#semester").val());
        } else {
            $("#semester").prop('disabled', true);
            patchSemester.text('');
        }
    });
    $("#semester").change(function () {
        var content = $(this).val();
        patchSemester.text(content);
    });
    $("#cycle").change(function () {
        var content = $(this).val();
        patchGroup.text(content);
    });
    $("#program").change(function () {
        var content = $(this).children(':selected').text();
        patchGroup.text(patchGroup.text() + " " + content);
    });
    $("#text").change(function () {
        var content = $(this).val();
        patchGroup.text(content);
    });

// Change year value in patch display
    $("#year").change(function () {
        var year = $(this).val();
        patchYear.text(year);
        year_arr = year.split('-');

        if (parseInt(year_arr[0]) % 2 === 0) { /* we are even */
            $("#patch_preview").addClass("year_even");
            $("#patch_preview").removeClass("year_odd");
        } else { /* we are odd */
            $("#patch_preview").addClass("year_odd");
            $("#patch_preview").removeClass("year_even");
        }
    });

// Adjust if founder
    $("#founder").change(function () {
        $("#patch_preview").toggleClass("founder");
    });

// Add a patch to order
    $("#addPatch").click(function () {
        $okToAdd = false;

        if ($("#patch_Implication").is(':checked')) {
            if ($("#group").val() != "" && $("#year").val() != "")
                $okToAdd = true;

            if ($("#group").val().indexOf("ORG") >= 0) {
                if ($("#semester").val() != "")
                    $okToAdd = true;
                else
                    $okToAdd = false;
            }

        }
        if ($("#patch_Employer").is(':checked')) {
            if ($("#program").val() != "" && $("#year").val() != "")
                $okToAdd = true;
        }
        if ($("#patch_Graduation").is(':checked')) {
            if ($("#cycle").val() != "" && $("#program").val() != "" && $("#year").val() != "")
                $okToAdd = true;
        }
        console.log($("#patch_Custom").is(':checked'));
        if ($("#patch_Custom").is(':checked')) {
            if ($("#text").val() != "")
                $okToAdd = true;
        }

        if ($okToAdd) {
            $lineOrder_length = $("#line_order tbody tr").length;
            $newPatch_text = $("#patch_preview p").text();
            $viewer_class = '<div class="tooltip ' + $("#patch_preview").attr("class") + '"><div class="tooltip-arrow"></div><div class="tooltip-inner">' + $newPatch_text + '</div></div>';

            $("#line_order tbody").append("<tr>" +
                "<td>" + ($lineOrder_length + 1) + "</td>" +
                "<td>" + $newPatch_text + "</td>" +
                "<td> <input type='number' class='form-control form-control-sm' id='quantity' name='quantity' min=1 value=1 /> </td>" +
                "<td> 4.00 $ </td>" +
                "<td class='aRight'> <button type='button' class='btn btn-sm btn-primary' data-template='" + $viewer_class + "' data-toggle='tooltip' data-html='true' title='<p>" + $newPatch_text + "</p>'>Aperçu</button> <button id='deleteRow' type='button' class='btn btn-sm btn-danger'>Retirer</button></td>" +
                "</tr>");


            $("#line_order tfoot").css("display", "none");

            // Enable tooltip
            $('[data-toggle="tooltip"]').tooltip();

            adjustPrice();

            // Show alert
            $(".alert-danger").hide();
            $(".alert-success").show().delay(5000).fadeOut();
        } else {
            // Show alert
            $(".alert-success").hide();
            $(".alert-danger").show().delay(5000).fadeOut();
        }
    });

// Bind delete function to remove row from line order
    $(document).on("click", "#deleteRow", function () {
        $(this).parent().parent().remove();

        if ($("#line_order tbody tr").length >= 1)
            $("#line_order tfoot").css("display", "none");
        else
            $("#line_order tfoot").css("display", "table-footer-group");

        $counter = 1;
        $("#line_order tbody td:first-child").each(function () {
            $(this).text($counter);
            $counter++;
        });

        adjustPrice();
    });

// Bind change function to adjust price according to quantity
    $(document).on("change", "input[name='quantity']", function () {
        adjustPrice();
    });

// Adjust price
    function adjustPrice() {
        $subtotal = 0;
        $("#line_order tbody tr").each(function () {
            $quantity = parseInt($(this).find("#quantity").val());
            $subtotal += 4 * $quantity;
        });

        $("#subtotal").text($subtotal.toFixed(2));
        $("#total").text(parseFloat($subtotal).toFixed(2));
    }

// Adjust year in input
    function fillYearSelect(nbDigit) {
        // Remove options
        $('#year').children('option:not(:first)').remove();
        var maxOffset = 44; // CHANGE HERE TO LIMIT NUMBER OF YEAR TO SHOW
        var d = new Date();

        for (var i = 1; i <= maxOffset; i++) {
            if (nbDigit == 1) {
                var option = "<option value=" + String(parseInt(d.getFullYear() - i)).substr(2) + ">" + parseInt(d.getFullYear() - i) + "</option>"
                $('#year').append(option);
            } else {
                var option = "<option value='" + String(parseInt(d.getFullYear() - i - 1)).substr(2) + " - " + String(parseInt(d.getFullYear() - i)).substr(2) + "'>" + parseInt(d.getFullYear() - i - 1) + " - " + parseInt(d.getFullYear() - i) + "</option>"
                $('#year').append(option);
            }
        }
    }